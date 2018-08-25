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
import be.unamur.mlvm.sampling.RandomSampleGenerator;
import be.unamur.mlvm.sampling.SampleGenerator;
import be.unamur.mlvm.test.Results;
import be.unamur.mlvm.test.TestUtils;
import be.unamur.mlvm.test.TrainingEvaluator;
import be.unamur.mlvm.vm.Constraint;
import be.unamur.mlvm.vm.VariabilityModel;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
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
//        int limit = 10;
        int SAMPLE_COUNT = 10;
        int AUGMENT_STEPS = 10;

        List<ClassifierFactory> classifiers = Arrays.asList(
                Classifiers.SVM_Poly(3,2,0.5)
        );
        List<VariabilityModel> models = new ArrayList<>();

        SplotUtils.loadSamplesDirectoryWithSplitConstraints("SPLOT")
                .forEach(models::add);


        SampleGenerator validationGenerator = new CombinatorialSampleGenerator();

        System.out.println("Loaded " + models.size() + " models");

        Map<Integer, Results> resultsMap = new TreeMap<>();

        IntStream.rangeClosed(14, 21).forEach(features -> {
            SampleGenerator trainingGenerator = new CombinatorialSampleGenerator();

            final String filename = "new/augmentedA/" + (limit >= 0 ? "l" + limit + "_" : "") + "F" + features;
            final String filename2 = "new/augmentedA/" + (limit >= 0 ? "l" + limit + "_" : "") + "Fto_" + features;


            Stream<VariabilityModel> modelsStream = models.stream()
                    .filter(x -> x.features().size() == features)
                    .filter(x -> x.constraints().size() > 0);

            if (limit >= 0)
                modelsStream = modelsStream.limit(limit);

            List<VariabilityModel> models1 = modelsStream
                    .collect(Collectors.toList());

            if (models1.isEmpty())
                return;

            System.out.println("Loading existing results for [" + Paths.get(filename).getFileName() + "] (F=" + features + ", count=" + models1.size() + ")");
            Map<Integer, Results> results = new TreeMap<>();
            Set<Integer> existing = new TreeSet<>();

            IntStream.rangeClosed(1, AUGMENT_STEPS)
                    .map(i -> i * 100 / AUGMENT_STEPS)
                    .forEach(c -> {
                        Path path = Paths.get("results", "splot", filename + "_C" + String.format("%03d", c) + "_raw.csv");
                        if (Files.exists(path)) {
                            Results rs = TestUtils.loadResults(path, models1, features);
                            results.compute(getKey(c), (k, v) -> Results.combine(v, rs));
                            existing.add(c);
                            System.out.println("Loading existing " + path.getFileName());
                        }
                    });

            Set<Integer> unloaded = IntStream.rangeClosed(1, AUGMENT_STEPS)
                    .map(i -> i * 100 / AUGMENT_STEPS)
                    .filter(x -> !existing.contains(x))
                    .boxed()
                    .collect(Collectors.toSet());

            if (unloaded.isEmpty()) {
                System.out.println("All results loaded from files");
            } else {
                System.out.println("Missing : " + unloaded.stream().map(Object::toString).collect(Collectors.joining(", ")));

                System.out.println("Running evaluation for [" + Paths.get(filename).getFileName() + "] (F=" + features + ", count=" + models1.size() + ")");

                int minRequired = 10;
                List<TrainedModel> trainedModels = models1.stream()
                        .filter(x -> x.constraints().size() >= minRequired)
                        .flatMap(model -> classifiers.stream()
                                .map(classifier -> new TrainedModel(model, classifier, trainingGenerator)))
                        .collect(Collectors.toList());

                System.out.println("Training models");
                TestUtils.forEach(trainedModels, TrainedModel::train);

                System.out.println("Augmenting models");


                List<TrainedModel> augmentedModels = new ArrayList<>();

                TestUtils.forEach(trainedModels, x -> x.getAugmentedModels(AUGMENT_STEPS, SAMPLE_COUNT)
                        .forEach(augmentedModels::add));

                System.out.println("Evaluating models");


                TestUtils.forEach(augmentedModels, x -> {
                    if (existing.contains(x.getAddedConstraintsStep()* 100 / AUGMENT_STEPS))
                        return;
                    TrainingEvaluator.MultiEvaluationResult v = x.evaluate(validationGenerator);
                    Results r1 = results.computeIfAbsent(getKey(x.getAddedConstraintsStep() * 100 / AUGMENT_STEPS),
                            i -> new Results(new ArrayList<>()));
                    r1.addResult(v);
                });
            }

            results.forEach((i, r1) -> {
                Results rx = resultsMap.compute(i, (i1, v) -> Results.combine(v, r1));
                TestUtils.saveResults(r1, "splot/" + filename + "_C" + String.format("%03d", i));
                TestUtils.saveResults(rx, "splot/" + filename2 + "_C" + String.format("%03d", i));
            });
        });
    }

    private static int getKey(int addedConstraintsCount) {
        return addedConstraintsCount;
    }


    private static class TrainedModel {

        private final VariabilityModel model;
        private final ClassifierFactory classifierFactory;
        private final SampleGenerator traningSetGenerator;
        private final int step;
        private LearningModel trainedModel;
        private List<Constraint> addedConstraints;

        TrainedModel(VariabilityModel model, ClassifierFactory classifierFactory, SampleGenerator generator) {
            this.model = model;
            this.classifierFactory = classifierFactory;
            this.traningSetGenerator = generator;
            this.step = 0;
        }


        private TrainedModel(VariabilityModel model, ClassifierFactory classifierFactory, SampleGenerator generator, LearningModel trainedModel, List<Constraint> addedConstraints, int step) {
            this.model = model;
            this.classifierFactory = classifierFactory;
            this.traningSetGenerator = generator;
            this.trainedModel = trainedModel;
            this.addedConstraints = addedConstraints;
            this.step = step;
        }

        void train() {
            LearningModelTrainer learningModelTrainer = new LearningModelTrainer(model,
                    capacity -> new WekaLearningModel(model, classifierFactory.create(), capacity));

            traningSetGenerator.generateSamples(model, learningModelTrainer);
            this.trainedModel = learningModelTrainer.getLearningModel();
            this.trainedModel.buildClassifier();
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


        Stream<TrainedModel> getAugmentedModels(int steps, int count) {
            List<Constraint> constraints = model.constraints().stream().map(model::getConstraint).collect(Collectors.toList());

            return IntStream.rangeClosed(0, count).boxed()
                    .flatMap(i -> IntStream.rangeClosed(1, steps)
                            .mapToObj(j -> new TrainedModel(model, classifierFactory, traningSetGenerator, trainedModel, pick(constraints, j * (constraints.size() - 1) / steps), j)));

        }

        private static List<Constraint> pick(List<Constraint> constraints, int count) {
            Collections.shuffle(constraints);
            return new ArrayList<>(constraints.subList(0, count));
        }

        int getAddedConstraintsStep() {
            return step;
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



