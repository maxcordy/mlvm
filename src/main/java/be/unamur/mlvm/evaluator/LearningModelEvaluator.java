package be.unamur.mlvm.evaluator;

import be.unamur.mlvm.reasoner.LearningModel;
import be.unamur.mlvm.reasoner.LearningModelFactory;
import be.unamur.mlvm.reasoner.Oracle;
import be.unamur.mlvm.util.Assert;
import be.unamur.mlvm.vm.Configuration;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;

public class LearningModelEvaluator {

    private final LearningModelFactory learningModelFactory;
    private final Oracle trainingOracle;
    private final Oracle validationOracle;

    /**
     * Create a new evaluator
     * @param learningModelFactory a factory that creates the learning model (cross-validation will create several times a model)
     * @param trainingOracle an oracle to validate the training data
     * @param validationOracle an oracle to validate the evaluation data
     */
    public LearningModelEvaluator(LearningModelFactory learningModelFactory, Oracle trainingOracle, Oracle validationOracle) {
        Assert.notNull(learningModelFactory);
        Assert.notNull(trainingOracle);
        Assert.notNull(validationOracle);
        this.learningModelFactory = learningModelFactory;
        this.trainingOracle = trainingOracle;
        this.validationOracle = validationOracle;
    }

    /**
     * Train a model with the training set, then validate it against the testing set
     * @param trainingSet
     * @param testingSet
     * @return
     */
    public EvaluationResult evaluate(List<Configuration> trainingSet, List<Configuration> testingSet) {
        LearningModel learningModel = learningModelFactory.create(trainingSet.size());
        // training
        trainingSet.forEach(sample -> learningModel.train(sample, trainingOracle.isValid(sample)));

        // evaluation
        Stream<TestResult> results = testingSet.stream()
                .map(sample -> compareResults(learningModel.isValid(sample), validationOracle.isValid(sample)));

        return new EvaluationResult(results);
    }

    /**
     * Cross-validate the given data set
     * @param dataSet
     * @param k numbers of cuts
     * @return
     */
    public EvaluationResult crossValidateKFold(List<Configuration> dataSet, int k) {

        Stream<TestResult> results = IntStream.range(0, k).mapToObj(x -> {
            int from = x * dataSet.size() / k;
            int to = (x + 1) * dataSet.size() / k;
            List<Configuration> testingSet = dataSet.subList(from, to);

            // training
            LearningModel learningModel = learningModelFactory.create(dataSet.size() - testingSet.size());
            dataSet.subList(0, from)
                    .forEach(sample -> learningModel.train(sample, trainingOracle.isValid(sample)));
            dataSet.subList(to, dataSet.size())
                    .forEach(sample -> learningModel.train(sample, trainingOracle.isValid(sample)));

            // evaluation
            return testingSet.stream()
                    .map(sample -> compareResults(learningModel.isValid(sample), validationOracle.isValid(sample)));
        }).flatMap(x -> x);

        return new EvaluationResult(results);
    }

    private TestResult compareResults(boolean actual, boolean expected) {
        if (actual)
            if (expected)
                return TestResult.TruePositive;
            else
                return TestResult.FalsePositive;
        else if (expected)
            return TestResult.FalseNegative;
        else
            return TestResult.TrueNegative;
    }
}
