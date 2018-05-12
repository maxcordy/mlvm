package be.unamur.mlvm.test.splot;

import be.unamur.mlvm.reasoner.weka.ClassifierFactory;
import be.unamur.mlvm.reasoner.weka.Classifiers;
import be.unamur.mlvm.sampling.CombinatorialSampleGenerator;
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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class TestSplotModels {

    public static void main(String[] args) throws Exception {

        // limite le nombre de modeles ayant le meme nombre de features
        int limit = -1;
        // limit = 10;

        List<ClassifierFactory> classifiers = Arrays.asList(
//                Classifiers.SVM_RBF(5),
                Classifiers.SVM_Poly(3, 2, 0.5),
                Classifiers.RandomForest(),
//                Classifiers.SVM_Puk(1, 0.1),
                Classifiers.RandomCommittee(),
                Classifiers.REPTree(),
                Classifiers.LogisticModelTree(),
                Classifiers.MultilayerPerceptron(),
                Classifiers.J48()
        );

        List<VariabilityModel> models = new ArrayList<>();

        loadSamplesDirectory("SPLOT")
                .forEach(models::add);

        List<SampleGenerator> generators = Collections.singletonList(new CombinatorialSampleGenerator());

        System.out.println("Loaded " + models.size() + " models");

        Results r = null;
        for (int i = 0; i < 25; i++) {
            int finalI = i;
            Stream<VariabilityModel> modelsStream = models.stream()
                    .filter(x -> x.features().size() == finalI);
            if(limit >= 0)
                    modelsStream = modelsStream.limit(limit);

            List<VariabilityModel> models1 = modelsStream
                    .collect(Collectors.toList());

            if (models1.isEmpty())
                continue;

            System.out.println("Running evaluation for features=" + i + ", models_count=" + models1.size());

            Results r1 = TrainingEvaluator.evaluateMany(models1, classifiers, generators, new CombinatorialSampleGenerator());
            if (r == null)
                r = r1;
            else
                r = Results.combine(r, r1);

            if(limit >= 0) {
                saveResults(r1, "l" + limit + "_F" + i);
                saveResults(r, "l" + limit + "_upToF" + i);
            } else {
                saveResults(r1, "F" + i);
                saveResults(r, "upToF" + i);
            }
        }
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
        return Files.list(Paths.get(TestSplotModels.class.getResource("/samples/" + s).toURI()))
                .map(TestSplotModels::loadFile);
    }

    private static VariabilityModel loadSampleFile(String s) throws Exception {
        return loadFile(Paths.get(TestSplotModels.class.getResource("/samples/" + s).toURI()));
    }

    private static VariabilityModel loadFile(Path x) {
        try {
            return SplotModelLoader.parse(x.toString());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
