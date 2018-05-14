package be.unamur.mlvm.test.splot;

import be.unamur.mlvm.evaluator.EvaluationResult;
import be.unamur.mlvm.reasoner.weka.ClassifierFactory;
import be.unamur.mlvm.reasoner.weka.Classifiers;
import be.unamur.mlvm.sampling.CombinatorialSampleGenerator;
import be.unamur.mlvm.sampling.SampleGenerator;
import be.unamur.mlvm.splot.SplotModelLoader;
import be.unamur.mlvm.test.Results;
import be.unamur.mlvm.test.TrainingEvaluator;
import be.unamur.mlvm.vm.VariabilityModel;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class TestSplotModels {

    public static void main(String[] args) throws Exception {

        // limite le nombre de modeles ayant le meme nombre de features
        int limit = -1;
        limit = 10;

        List<ClassifierFactory> classifiers = Arrays.asList(
//                Classifiers.SVM_RBF(5),
//                Classifiers.SVM_Poly(3, 2, 0.5),
//                Classifiers.RandomForest(),
//                Classifiers.SVM_Puk(1, 0.1),
//                Classifiers.RandomCommittee(),
//                Classifiers.REPTree(),
//                Classifiers.LogisticModelTree(),
//                Classifiers.MultilayerPerceptron(),
//                Classifiers.J48()
                Classifiers.NaiveBayesUpdateable(),
                Classifiers.HoeffdingTree(),
                Classifiers.IBk(),
                Classifiers.KStar(),
                Classifiers.StochasticGradientDescend(),
                Classifiers.LWL()
//                HoeffdingTree, IBk, KStar, LWL
        );

        List<VariabilityModel> models = new ArrayList<>();

        loadSamplesDirectory("SPLOT")
                .forEach(models::add);

        List<SampleGenerator> generators = Collections.singletonList(new CombinatorialSampleGenerator());

        System.out.println("Loaded " + models.size() + " models");

        Results r = null;
        for (int i = 0; i < 50; i++) {
            String filename, filename2;
            if (limit >= 0) {
                filename = "l" + limit + "_F" + i;
                filename2 = "l" + limit + "_upToF" + i;
            } else {
                filename = "F" + i;
                filename2 = "upToF" + i;
            }

            filename = "updatable_" + filename;
            filename2 = "updatable_" + filename2;


            int finalI = i;
            Stream<VariabilityModel> modelsStream = models.stream()
                    .filter(x -> x.features().size() == finalI);
            if (limit >= 0)
                modelsStream = modelsStream.limit(limit);

            List<VariabilityModel> models1 = modelsStream
                    .collect(Collectors.toList());

            if (models1.isEmpty())
                continue;

            if (Files.exists(Paths.get("results", "splot", filename + "_raw.csv"))) {
                System.out.println("Loading existing evaluation for features=" + i + ", models_count=" + models1.size());
                Results r1 = loadResults(Paths.get("results", "splot", filename + "_raw.csv"), models1, classifiers, generators);

                if (r == null)
                    r = r1;
                else
                    r = Results.combine(r, r1);
            } else {

                System.out.println("Running evaluation for features=" + i + ", models_count=" + models1.size());

                Results r1 = TrainingEvaluator.evaluateMany(models1, classifiers, generators, new CombinatorialSampleGenerator());
                if (r == null)
                    r = r1;
                else
                    r = Results.combine(r, r1);

                saveResults(r1, filename);
                saveResults(r, filename2);
            }
        }
    }

    private static Results loadResults(Path path, List<VariabilityModel> models, List<ClassifierFactory> classifiers, List<SampleGenerator> generators) {
        ArrayList<TrainingEvaluator.MultiEvaluationResult> results = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(path.toFile()))) {
            String line = reader.readLine();
            while ((line = reader.readLine()) != null) {
                String[] split = line.split(";");

                Optional<ClassifierFactory> classifierFactory = classifiers.stream().filter(x -> x.getLabel().equals(split[0])).findAny();
                if (!classifierFactory.isPresent())
                    continue;

                VariabilityModel model = models.stream().filter(x -> x.getName().equals(split[2])).findAny()
                        .orElseThrow(() -> new RuntimeException("Model not found for " + split[2]));

                results.add(new TrainingEvaluator.MultiEvaluationResult(model, classifierFactory.get(), generators.get(0), -1,
                        new EvaluationResult(Integer.parseInt(split[3]), Integer.parseInt(split[4]), Integer.parseInt(split[5]), Integer.parseInt(split[6]))));

            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return new Results(results);
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
