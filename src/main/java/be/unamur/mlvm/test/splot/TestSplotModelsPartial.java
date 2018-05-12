package be.unamur.mlvm.test.splot;

import be.unamur.mlvm.reasoner.weka.ClassifierFactory;
import be.unamur.mlvm.reasoner.weka.Classifiers;
import be.unamur.mlvm.sampling.CombinatorialSampleGenerator;
import be.unamur.mlvm.sampling.RandomSampleGenerator;
import be.unamur.mlvm.sampling.SampleGenerator;
import be.unamur.mlvm.splot.SplotModelLoader;
import be.unamur.mlvm.test.Results;
import be.unamur.mlvm.test.TrainingEvaluator;
import be.unamur.mlvm.vm.VariabilityModel;

import java.io.IOException;
import java.io.PrintStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.Duration;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class TestSplotModelsPartial {



    public static void main(String[] args) throws Exception {
        Instant start = Instant.now();

        int maxFeatures = 13;

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

        models.removeIf(x -> x.features().size() > maxFeatures);

        for(int i = 0 ; i < 10; i++) {
            double ratio = 1 - i * 0.1;
            System.out.println("Running evaluation for features=" + i + ", models_count=" + models.size());
        List<SampleGenerator> generators = Collections.singletonList(new RandomSampleGenerator(ratio, true));

            Results r1 = TrainingEvaluator.evaluateMany(models, classifiers, generators, new CombinatorialSampleGenerator());
            saveResults(r1, String.format("partial_F%d_P%02d", maxFeatures, (int) Math.round(ratio * 100)));
        }


        Instant end = Instant.now();
        System.out.println("Finished after " + Duration.between(start, end).toString()
                .substring(2)
                .replaceAll("(\\d[HMS])(?!$)", "$1 ")
                .toLowerCase());
    }

    private static void saveResults(Results results, String outName) throws IOException {
        Files.createDirectories(Paths.get("./results/splot"));
        try (PrintStream out = new PrintStream("./results/splot/" + outName + "_stats.csv")) {
            results.displayStats(out);
        }
        try (PrintStream out = new PrintStream("./results/splot/" + outName + "_cross.csv")) {
            results.displayScoreVsConstraints(out);
        }
        try (PrintStream out = new PrintStream("./results/splot/" + outName + "_raw.csv")) {
            results.displayRawResults(out);
        }
    }

    private static Stream<VariabilityModel> loadSamplesDirectory(String s) throws Exception {
        return Files.list(Paths.get(TestSplotModelsPartial.class.getResource("/samples/" + s).toURI()))
                .map(TestSplotModelsPartial::loadFile);
    }

    private static VariabilityModel loadSampleFile(String s) throws Exception {
        return loadFile(Paths.get(TestSplotModelsPartial.class.getResource("/samples/" + s).toURI()));
    }

    private static VariabilityModel loadFile(Path x) {
        try {
            return SplotModelLoader.parse(x.toString());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
