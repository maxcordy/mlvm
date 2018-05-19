package be.unamur.mlvm.test.splot;

import be.unamur.mlvm.evaluator.EvaluationResult;
import be.unamur.mlvm.evaluator.LearningModelTrainer;
import be.unamur.mlvm.evaluator.LearningModelValidator;
import be.unamur.mlvm.reasoner.LearningModel;
import be.unamur.mlvm.reasoner.Oracle;
import be.unamur.mlvm.reasoner.weka.ClassifierFactory;
import be.unamur.mlvm.reasoner.weka.Classifiers;
import be.unamur.mlvm.reasoner.weka.WekaLearningModel;
import be.unamur.mlvm.sampling.CombinatorialSampleGenerator;
import be.unamur.mlvm.sampling.SampleGenerator;
import be.unamur.mlvm.test.Results;
import be.unamur.mlvm.test.TestUtils;
import be.unamur.mlvm.test.TrainingEvaluator;
import be.unamur.mlvm.vm.Constraint;
import be.unamur.mlvm.vm.VariabilityModel;
import com.sun.org.apache.regexp.internal.RE;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import java.util.function.Supplier;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import java.util.stream.StreamSupport;

public class TestSplotModels_Augment {


    /**
     * Tests various training algorithms with various models, sampling with the full set and then testing it
     * Use real models from SPLOT library with less than 20,000 configurations
     */
    public static void main(String[] args) throws Exception {


        // limite le nombre de modeles ayant le meme nombre de features
        int limit = -1;
        int MAX_AUGMENTED = 5;
//        limit = 10;

        List<ClassifierFactory> classifiers = Arrays.asList(
                Classifiers.SVM_RBF(5),
                Classifiers.SVM_Poly(3, 2, 0.5),
                Classifiers.RandomForest(),
                Classifiers.SVM_Puk(1, 0.1),
                Classifiers.RandomCommittee(),
                Classifiers.REPTree(),
                Classifiers.LogisticModelTree(),
                Classifiers.MultilayerPerceptron(),
                Classifiers.J48(),
                Classifiers.NaiveBayesUpdateable(),
                Classifiers.HoeffdingTree(),
//                Classifiers.IBk(),
//                Classifiers.KStar(),
                Classifiers.StochasticGradientDescend()
//                Classifiers.LWL()
        );
        List<VariabilityModel> models = new ArrayList<>();

        SplotUtils.loadSamplesDirectory("SPLOT")
                .forEach(models::add);


        SampleGenerator generator = new CombinatorialSampleGenerator();

        System.out.println("Loaded " + models.size() + " models");

        Map<Integer, Results> r = new TreeMap<>();
        for (int features = 0; features <= 21; features++) {

            final String filename = "augmented/" + (limit >= 0 ? "l" + limit + "_" : "") + "F" + features;
            final String filename2 = "augmented/" + (limit >= 0 ? "l" + limit + "_" : "") + "upToF" + features;


            int finalFeatures = features;
            Stream<VariabilityModel> modelsStream = models.stream()
                    .filter(x -> x.features().size() == finalFeatures);

            if (limit >= 0)
                modelsStream = modelsStream.limit(limit);

            List<VariabilityModel> models1 = modelsStream
                    .collect(Collectors.toList());

            if (models1.isEmpty())
                continue;


            List<TrainedModel> trainedModels = models1.stream()
                    .flatMap(model -> classifiers.stream()
                            .map(classifier -> new TrainedModel(model, classifier, generator)))
                    .collect(Collectors.toList());

            System.out.println("Training models");
            TestUtils.forEach(trainedModels, TrainedModel::train);

            System.out.println("Augmenting models");


            List<TrainedModel> augmentedModels = new ArrayList<>();

            TestUtils.forEach(trainedModels, x -> x.getAugmentedModels(MAX_AUGMENTED)
                    .forEach(augmentedModels::add));

            System.out.println("Evaluating models");

            Map<Integer, Results> results = new TreeMap<>();
            TestUtils.forEach(augmentedModels, x -> {
                TrainingEvaluator.MultiEvaluationResult v = x.evaluate(generator);
                Results r1 = results.computeIfAbsent(x.getAddedConstraintsCount(), i -> new Results(new ArrayList<>()));
                r1.addResult(v);
            });

            results.forEach((i, r1) -> {
                Results rx = r.compute(i, (i1, v) -> Results.combine(v, r1));
                TestUtils.saveResults(r1, "splot/" + filename + "_C" + i);
                TestUtils.saveResults(rx, "splot/" + filename2 + "_C" + i);
            });
        }
    }


    private static class TrainedModel {

        private final VariabilityModel model;
        private final ClassifierFactory classifierFactory;
        private final SampleGenerator traningSetGenerator;
        private Oracle trainedModel;
        private List<Constraint> addedConstraints;

        public TrainedModel(VariabilityModel model, ClassifierFactory classifierFactory, SampleGenerator generator) {
            this.model = model;
            this.classifierFactory = classifierFactory;
            this.traningSetGenerator = generator;
        }


        private TrainedModel(VariabilityModel model, ClassifierFactory classifierFactory, SampleGenerator generator, Oracle trainedModel, List<Constraint> addedConstraints) {
            this.model = model;
            this.classifierFactory = classifierFactory;
            this.traningSetGenerator = generator;
            this.trainedModel = trainedModel;
            this.addedConstraints = addedConstraints;
        }

        public void train() {
            LearningModelTrainer learningModelTrainer = new LearningModelTrainer(model,
                    capacity -> new WekaLearningModel(model, classifierFactory.create(), capacity));

            traningSetGenerator.generateSamples(model, learningModelTrainer);
            this.trainedModel = learningModelTrainer.getLearningModel();
        }


        TrainingEvaluator.MultiEvaluationResult evaluate(SampleGenerator generator) {
            Oracle modelToValidate = trainedModel;
            if (addedConstraints != null) {
                modelToValidate = conf ->
                        addedConstraints.stream().allMatch(c -> c.fulfil(conf))
                                && trainedModel.isValid(conf);
            }

            LearningModelValidator validator = new LearningModelValidator(model, modelToValidate);
            generator.generateSamples(model, validator);
            EvaluationResult results = validator.getResults();
            return new TrainingEvaluator.MultiEvaluationResult(model, classifierFactory, traningSetGenerator, -1, results);
        }


        Stream<TrainedModel> getAugmentedModels(int max) {

            List<Constraint> constraints = model.constraints().stream().map(model::getConstraint).collect(Collectors.toList());

            return getAugmentedModels(constraints, Math.min(max, constraints.size()))
                    .map(c -> new TrainedModel(model, classifierFactory, traningSetGenerator, trainedModel, c));


        }

        private static Stream<List<Constraint>> getAugmentedModels(List<Constraint> constraints, int max) {
            int[] ids = new int[max];
            for (int i = 0; i < ids.length; i++) ids[i] = i;


            for (int i = ids.length - 1; i >= 0; i--) {
                if (ids[i] >= constraints.size() - 1)
                    if (i > 0)
                        continue;
                    else
                        break;
                ids[i]++;
                for (int j = i + 1; j < ids.length; j++)
                    ids[j] = ids[j - 1] + 1;
            }

            Iterable<List<Constraint>> iterable = () -> new ConstraintListSupplier(constraints, max);
            return StreamSupport.stream(iterable.spliterator(), false);
        }

        public int getAddedConstraintsCount() {
            return addedConstraints.size();
        }
    }

    private static class ConstraintListSupplier implements Iterator<List<Constraint>> {
        private final List<Constraint> constraints;
        private final int[] ids;
        private int min = 0;

        public ConstraintListSupplier(List<Constraint> constraints, int max) {
            this.constraints = constraints;
            ids = new int[max];
            for (int i = 0; i < ids.length; i++) {
                ids[i] = i;
            }
        }

        @Override
        public boolean hasNext() {
            return ids[0] < constraints.size();
        }

        @Override
        public List<Constraint> next() {
            ArrayList<Constraint> cs = new ArrayList<>(ids.length);
            for (int id : ids) {
                if (id >= constraints.size())
                    break;
                cs.add(constraints.get(id));
            }
            inc();
            return cs;
        }

        private void inc() {
            int p = ids.length - 1;
            while (p > 0 && ids[p] >= constraints.size() - 1)
                p--;

            ids[p]++;
            for (int j = p + 1; j < ids.length; j++)
                ids[j] = ids[j - 1] + 1;
        }
    }
}



