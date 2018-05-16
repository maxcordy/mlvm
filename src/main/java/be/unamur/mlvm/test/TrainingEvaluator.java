package be.unamur.mlvm.test;

import be.unamur.mlvm.evaluator.EvaluationResult;
import be.unamur.mlvm.evaluator.LearningModelEvaluator;
import be.unamur.mlvm.reasoner.Oracle;
import be.unamur.mlvm.reasoner.weka.ClassifierFactory;
import be.unamur.mlvm.reasoner.weka.WekaLearningModel;
import be.unamur.mlvm.sampling.SampleGenerator;
import be.unamur.mlvm.test.splot.ConstraintRemover;
import be.unamur.mlvm.vm.*;
import fm.FeatureModelException;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;


public class TrainingEvaluator {

    public static class MultiEvaluationResult {
        public final VariabilityModel model;
        public final String classifier;
        public final String generator;
        public final Integer kFold;
        public final EvaluationResult result;

        public MultiEvaluationResult(VariabilityModel model, ClassifierFactory classifierFactory, SampleGenerator generator, Integer kFold, EvaluationResult result) {
            this.model = model;
            this.classifier = classifierFactory.getLabel();
            this.generator = generator.getLabel();
            this.kFold = kFold;
            this.result = result;
        }

        public MultiEvaluationResult(VariabilityModel model, String classifierFactor, String generator, Integer kFold, EvaluationResult result) {
            this.model = model;
            this.classifier = classifierFactor;
            this.generator = generator;
            this.kFold = kFold;
            this.result = result;
        }
    }

    public static EvaluationResult kFoldsEvaluate(VariabilityModel model, ClassifierFactory classifierFactory, SampleGenerator generator, int kFolds) throws FeatureModelException {
        LearningModelEvaluator ev = new LearningModelEvaluator(model,
                capacity -> new WekaLearningModel(model, classifierFactory.create(), capacity),
                model, model);

        return ev.crossValidateKFold(generator, kFolds);
    }

    public static EvaluationResult evaluate(VariabilityModel model, ClassifierFactory classifierFactory, SampleGenerator trainingGenerator, SampleGenerator validationGenerator) throws FeatureModelException {
        LearningModelEvaluator ev = new LearningModelEvaluator(model,
                capacity -> new WekaLearningModel(model, classifierFactory.create(), capacity),
                model, model);

        return ev.evaluate(trainingGenerator, validationGenerator);
    }

    public static EvaluationResult evaluateRemoving(VariabilityModel model, ClassifierFactory classifierFactory, SampleGenerator trainingGenerator, SampleGenerator validationGenerator, ConstraintRemover remover) throws FeatureModelException {

        VariabilityModel model1 = model;
        List<ConstraintId> constraintIds = remover.pickForRemoval(model);
        for (ConstraintId x : constraintIds)
            model1 = model1.remove(x);

        LearningModelEvaluator ev = new LearningModelEvaluator(
                model,
                capacity -> new WekaLearningModel(model, classifierFactory.create(), capacity),
                model1,
                createModelAugmenter(constraintIds.stream().map(model::getConstraint).collect(Collectors.toList())),
                model);

        return ev.evaluate(trainingGenerator, validationGenerator);
    }

    private static Function<Oracle, Oracle> createModelAugmenter(List<Constraint> constraints) {
        return oracle -> config -> {
            return oracle.isValid(config) && constraints.stream().allMatch(x -> x.fulfil(config));
        };
    }

    public static Results kFoldEvaluateMany(List<VariabilityModel> models,
                                            List<ClassifierFactory> classifierFactory,
                                            List<SampleGenerator> generators,
                                            int kFolds) throws FeatureModelException {

        List<MultiEvaluationResult> results = new ArrayList<>();

        int p = 0;
        int c = 0;
        long start = System.currentTimeMillis();
        int t = models.size() * classifierFactory.size() * generators.size();

        for (VariabilityModel model : models)
            for (ClassifierFactory factory : classifierFactory)
                for (SampleGenerator generator : generators) {
                    int p1 = (c++ * 100 + t / 2) / t;
                    if (p != p1) {
                        Duration remaining = Duration.ofMillis((long) ((t - c + 0.0) * (System.currentTimeMillis() - start) / c));
                        System.out.printf("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t%d%% - Rem: %d:%02d\n", (p = p1), remaining.toMinutes(), remaining.getSeconds() % 60);
                    }

                    results.add(new MultiEvaluationResult(model, factory, generator, kFolds,
                            kFoldsEvaluate(model, factory, generator, kFolds)));
                }

        return new Results(results);
    }

    public static Results evaluateMany(List<VariabilityModel> models,
                                       List<ClassifierFactory> classifierFactory,
                                       List<SampleGenerator> generators,
                                       SampleGenerator validationGenerator)
            throws FeatureModelException {

        List<MultiEvaluationResult> results = new ArrayList<>();

        int p = 0;
        int c = 0;
        long start = System.currentTimeMillis();
        int t = models.size() * classifierFactory.size() * generators.size();

        for (VariabilityModel model : models) {

            for (ClassifierFactory factory : classifierFactory)


                for (SampleGenerator generator : generators) {
                    int p1 = (c++ * 100 + t / 2) / t;
                    if (p != p1) {
                        Duration remaining = Duration.ofMillis((long) ((t - c + 0.0) * (System.currentTimeMillis() - start) / c));
                        System.out.printf("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t%d%% - Rem: %d:%02d\n", (p = p1), remaining.toMinutes(), remaining.getSeconds() % 60);
                    }

                    results.add(new MultiEvaluationResult(model, factory, generator, -1,
                            evaluate(model, factory, generator, validationGenerator)));
                }
        }

        return new Results(results);
    }


    public static Results evaluateManyRemoving(List<VariabilityModel> models,
                                               List<ClassifierFactory> classifierFactory,
                                               List<SampleGenerator> generators,
                                               SampleGenerator validationGenerator,
                                               List<ConstraintRemover> removers)
            throws FeatureModelException {

        List<MultiEvaluationResult> results = new ArrayList<>();

        int p = 0;
        int c = 0;
        long start = System.currentTimeMillis();
        int t = models.size() * classifierFactory.size() * generators.size();

        for (VariabilityModel model : models) {


            for (ClassifierFactory factory : classifierFactory)
                for (SampleGenerator generator : generators)
                    for (ConstraintRemover remover : removers) {

                        int p1 = (c++ * 100 + t / 2) / t;
                        if (p != p1) {
                            Duration remaining = Duration.ofMillis((long) ((t - c + 0.0) * (System.currentTimeMillis() - start) / c));
                            System.out.printf("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t%d%% - Rem: %d:%02d\n", (p = p1), remaining.toMinutes(), remaining.getSeconds() % 60);
                        }

                        results.add(new MultiEvaluationResult(model, factory, generator, -1,
                                evaluateRemoving(model, factory, generator, validationGenerator, remover)));
                    }
        }

        return new Results(results);
    }
}