package be.unamur.mlvm.evaluator;

import be.unamur.mlvm.reasoner.LearningModel;
import be.unamur.mlvm.reasoner.LearningModelFactory;
import be.unamur.mlvm.reasoner.Oracle;
import be.unamur.mlvm.sampling.SampleGenerator;
import be.unamur.mlvm.util.Assert;
import be.unamur.mlvm.vm.Configuration;
import be.unamur.mlvm.vm.VariabilityModel;

import java.util.Collections;
import java.util.List;
import java.util.function.Function;
import java.util.stream.IntStream;

public class LearningModelEvaluator {

    private final LearningModelFactory learningModelFactory;
    private final Oracle trainingOracle;
    private final Oracle validationOracle;
    private final VariabilityModel vm;
    private Function<Oracle, Oracle> postTraining;

    public LearningModelEvaluator(VariabilityModel vm, LearningModelFactory learningModelFactory, Oracle trainingOracle, Oracle validationOracle) {
        this(vm, learningModelFactory, trainingOracle, null, validationOracle);
    }

    public LearningModelEvaluator(VariabilityModel vm, LearningModelFactory learningModelFactory,
                                  Oracle trainingOracle,
                                  Function<Oracle, Oracle> postTraining,
                                  Oracle validationOracle) {
        this.vm = vm;
        Assert.notNull(vm);
        Assert.notNull(learningModelFactory);
        Assert.notNull(trainingOracle);
        Assert.notNull(validationOracle);
        this.postTraining = postTraining;
        this.learningModelFactory = learningModelFactory;
        this.trainingOracle = trainingOracle;
        this.validationOracle = validationOracle;
    }

    public EvaluationResult evaluate(SampleGenerator samplingGenerator, SampleGenerator validationGenerator) {

//        System.out.println("Loading training set");
        LearningModelTrainer learningModelTrainer = new LearningModelTrainer(trainingOracle, learningModelFactory);
        samplingGenerator.generateSamples(vm, learningModelTrainer);
        LearningModel learningModel = learningModelTrainer.getLearningModel();

//        System.out.println("Building classifier");
        learningModel.buildClassifier();

        Oracle learnedModel = postTraining != null ? postTraining.apply(learningModel) : learningModel;

//        System.out.println("Validating classifier");
        LearningModelValidator validator = new LearningModelValidator(validationOracle, learnedModel);
        long startTime = System.currentTimeMillis();
        validationGenerator.generateSamples(vm, validator);
        long time = System.currentTimeMillis() - startTime;
        System.out.println("Validation time : " + (time * 1.0 / validator.getResults().getCount()));
        return validator.getResults();
    }

    public EvaluationResult crossValidateKFold(SampleGenerator samplesGenerator, int k) {

        List<Configuration> dataSet = SampleCollector.collect(vm, samplesGenerator);
        Collections.shuffle(dataSet);

        return IntStream.range(0, k)
                .mapToObj(x -> evaluate(new KFoldTrainingSetGenerator(dataSet, k, x), new KFoldValidationSetGenerator(dataSet, k, x)))
                .reduce(EvaluationResult::mergeWith)
                .orElseThrow(() -> new RuntimeException("k == 0"));
    }


}


