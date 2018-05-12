package be.unamur.mlvm.test.splot;

import be.unamur.mlvm.reasoner.weka.ClassifierFactory;
import be.unamur.mlvm.reasoner.weka.Classifiers;
import be.unamur.mlvm.sampling.CombinatorialSampleGenerator;
import be.unamur.mlvm.sampling.SampleGenerator;
import be.unamur.mlvm.splot.SplotModelLoader;
import be.unamur.mlvm.test.Results;
import be.unamur.mlvm.test.TrainingEvaluator;
import be.unamur.mlvm.vm.ConstraintId;
import be.unamur.mlvm.vm.IndexedVariabilityModel;
import be.unamur.mlvm.vm.VariabilityModel;

import java.io.PrintStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class TestSplotModels_RemoveX {


    private static final int MAX_CONFIGURATIONS = 10000;

    /**
     * Tests various training algorithms with various models, sampling with the full set and then testing it
     * Use real models from SPLOT library with less than 20,000 configurations
     */
    public static void main(String[] args) throws Exception {
        for (int remove = 1; remove < 10; remove++) {
            testRemoving(remove);
        }
    }

    private static void testRemoving(int REMOVE) throws Exception {
        String OUTPUT_NAME = "test_" + MAX_CONFIGURATIONS + "_removeRot_" + REMOVE;

        List<ClassifierFactory> classifiers = Arrays.asList(
                Classifiers.SVM_Poly(3, 2, 0.5),
//                Classifiers.SVM_RBF(5),
                Classifiers.RandomForest(),
                Classifiers.SVM_Puk(1, 0.1),
                Classifiers.RandomCommittee(),
//                Classifiers.REPTree(),
//                Classifiers.LogisticModelTree(),
                Classifiers.MultilayerPerceptron()
//                Classifiers.J48()
        );


        List<VariabilityModel> models = new ArrayList<>();

        loadSamplesDirectory("SPLOT")
                .forEach(models::add);

        System.out.println("Loaded " + models.size() + " models");
        System.out.println("Removing models with more than " + MAX_CONFIGURATIONS + " configurations");
        models.removeIf(x -> Math.pow(2, x.features().size()) > MAX_CONFIGURATIONS);

        System.out.println("Removing models with less than " + REMOVE + " constraints");
        models.removeIf(x -> (x.constraints().size() <= REMOVE));


        System.out.println("Duplicating models");
        List<VariabilityModel> models1 = models;
        models = new ArrayList<>();
        for (VariabilityModel model1 : models1) {
            IndexedVariabilityModel model = (IndexedVariabilityModel) model1;
            models.add(model);
            if(model.constraints().size() <= REMOVE)
                continue;

            IndexedVariabilityModel model2 = model;
            for (ConstraintId removal : model.constraints()) {
                model2 = (IndexedVariabilityModel) model2.remove(removal);
                model2.addConstraint(removal, model.getConstraint(removal));
//                Removing tree constraint ?
//                if(model.getConstraint(removal) instanceof TreeConstraint)
//                    continue;
                models.add(model2);
            }
        }


        System.out.println("Remain: " + models.size() + " models");

        System.out.println("features stats : " + models.stream().collect(Collectors.summarizingInt(x -> x.features().size())));

        System.out.println("constraints stats : " + models.stream().collect(Collectors.summarizingInt(x -> x.constraints().size())));

        List<SampleGenerator> generators = Collections.singletonList(new CombinatorialSampleGenerator());

        System.out.println(">evaluating");
        Results results = TrainingEvaluator.evaluateManyRemoving(models, classifiers, generators, new CombinatorialSampleGenerator(),
                Collections.singletonList(ConstraintRemover.takeN(REMOVE)));

        Files.createDirectories(Paths.get("./results"));
        try (PrintStream out = new PrintStream("./results/" + OUTPUT_NAME + "_stats.csv")) {
            results.displayStats(out);
        }
        try (PrintStream out = new PrintStream("./results/" + OUTPUT_NAME + "_cross.csv")) {
            results.displayScoreVsConstraints(out);
        }
        try (PrintStream out = new PrintStream("./results/" + OUTPUT_NAME + "_raw.csv")) {
            results.displayRawResults(out);
        }
    }


    private static Stream<VariabilityModel> loadSamplesDirectory(String s) throws Exception {
        return Files.list(Paths.get(TestSplotModels_RemoveX.class.getResource("/samples/" + s).toURI()))
                .map(TestSplotModels_RemoveX::loadFile);
    }


    private static VariabilityModel loadFile(Path x) {
        try {
            return SplotModelLoader.parse(x.toString());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
