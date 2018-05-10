package be.unamur.mlvm.test.splot;

import be.unamur.mlvm.reasoner.weka.ClassifierFactory;
import be.unamur.mlvm.reasoner.weka.Classifiers;
import be.unamur.mlvm.sampling.CombinatorialSampleGenerator;
import be.unamur.mlvm.sampling.SampleGenerator;
import be.unamur.mlvm.splot.SplotModelLoader;
import be.unamur.mlvm.test.Results;
import be.unamur.mlvm.test.TrainingEvaluator;
import be.unamur.mlvm.vm.*;

import java.io.PrintStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class TestManualSplotModels {

    private static final int MAX_CONFIGURATIONS = 20000;
    private static final String OUTPUT_NAME = "test_SPLOT_" + MAX_CONFIGURATIONS;

    public static void main(String[] args) throws Exception {
        List<ClassifierFactory> classifiers = Arrays.asList(
                Classifiers.SVM_RBF(5),
                Classifiers.SVM_Poly(3, 2, 0.5),
                Classifiers.RandomForest(),
                Classifiers.SVM_Puk(1, 0.1),
                Classifiers.RandomCommittee(),
                Classifiers.REPTree(),
                Classifiers.LogisticModelTree(),
                Classifiers.MultilayerPerceptron(),
                Classifiers.J48()
        );


        List<VariabilityModel> models = new ArrayList<>();

        loadSamplesDirectory("SPLOT")
                .forEach(models::add);

        System.out.println("Loaded " + models.size() + " models");
        System.out.println("Removing models with configurations > " + MAX_CONFIGURATIONS);
        models.removeIf(x -> Math.pow(2, x.features().size()) > MAX_CONFIGURATIONS);

        System.out.println("features stats : " + models.stream().collect(Collectors.summarizingInt(x -> x.features().size())));

        System.out.println("constraints stats : " + models.stream().collect(Collectors.summarizingInt(x -> x.constraints().size())));

        System.out.println("features counts : " + models.stream().collect(Collectors.groupingBy(x -> x.features().size(), Collectors.counting())));

        List<SampleGenerator> generators = Collections.singletonList(new CombinatorialSampleGenerator());

        System.out.println(">evaluating");
        Results results = TrainingEvaluator.evaluateMany(models, classifiers, generators, new CombinatorialSampleGenerator());

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
        return Files.list(Paths.get(TestManualSplotModels.class.getResource("/samples/" + s).toURI()))
                .map(TestManualSplotModels::loadFile);
    }

    private static VariabilityModel loadSampleFile(String s) throws Exception {
        return loadFile(Paths.get(TestManualSplotModels.class.getResource("/samples/" + s).toURI()));
    }

    private static VariabilityModel loadFile(Path x) {
        try {
            return SplotModelLoader.parse(x.toString());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
