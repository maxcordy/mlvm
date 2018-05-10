package be.unamur.mlvm.test.scad;


import be.unamur.mlvm.reasoner.weka.ClassifierFactory;
import be.unamur.mlvm.reasoner.weka.Classifiers;
import be.unamur.mlvm.sampling.CombinatorialSampleGenerator;
import be.unamur.mlvm.sampling.SampleGenerator;
import be.unamur.mlvm.scad.ScadConfigurationEvaluator;
import be.unamur.mlvm.scad.ScadModelLoader;
import be.unamur.mlvm.test.Results;
import be.unamur.mlvm.test.TrainingEvaluator;
import be.unamur.mlvm.vm.*;
import fm.FeatureModelException;
import org.json.simple.parser.ParseException;

import java.io.IOException;
import java.io.PrintStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class ScadModelsGeneratedTrainer {


    private static final Path OPENSCAD_PATH = Paths.get("C:", "Program Files", "OpenSCAD", "openscad.exe");
    private static final Path SLIC3R_PATH = Paths.get("C:", "Program Files", "Slic3r", "slic3r-console.exe");
    private static final Path SCAD_FILES_ROOT = Paths.get("d:", "scadFiles");

    private static final int RANGE_PARTITION = 20;
    private static final int RANGE_PARTITION1 = 21;

    private static final String OUTPUT_NAME = "test_SCAD";



    public static void main(String[] args) throws IOException, FeatureModelException {

        List<VariabilityModel> models = listAllScadFiles()
                .map(ScadModelsGeneratedTrainer::loadJson)
                .flatMap(o -> o.map(Stream::of).orElseGet(Stream::empty))
                .collect(Collectors.toList());

        CombinatorialSampleGenerator sampleGenerator1 = new CombinatorialSampleGenerator(RANGE_PARTITION);
        CombinatorialSampleGenerator sampleGenerator2 = new CombinatorialSampleGenerator(RANGE_PARTITION1);

        System.out.println("Loaded models: " + models.size());
        models.removeIf(x -> estimateDomainSize(x, RANGE_PARTITION) >= 20000);
        System.out.println("Loaded models: " + models.size());
        models.removeIf(x -> !isModelComplete(x, sampleGenerator1));
        models.removeIf(x -> !isModelComplete(x, sampleGenerator2));

        System.out.println("Remaining models: " + models.size());


        List<ClassifierFactory> classifiers = Arrays.asList(
                Classifiers.SVM_RBF(5),
                Classifiers.SVM_Poly(3, 2, 0.5),
                Classifiers.SVM_Poly(3, 2, 7),
                Classifiers.SVM_Poly(7, 2, 0),
                Classifiers.RandomForest(),
                Classifiers.SVM_Puk(1, 0.1),
                Classifiers.RandomCommittee(),
//                Classifiers.REPTree(),
//                Classifiers.LogisticModelTree(),
                Classifiers.StochasticGradientDescend(),
                Classifiers.NaiveBayes(),
                Classifiers.HoeffdingTree(),
                Classifiers.LogisticRegression(),
                Classifiers.MultilayerPerceptron(),
                Classifiers.J48()
        );


//        CombinatorialSampleGenerator c = new CombinatorialSampleGenerator(RANGE_PARTITION);
//        DoubleSummaryStatistics collect = models.stream()
//                .map(model -> {
//                    ScadConfigurationEvaluator ev = new ScadConfigurationEvaluator(OPENSCAD_PATH, SLIC3R_PATH, SCAD_FILES_ROOT.resolve(model.getName()), model);
//                    List<Configuration> configurations = c.generateSamples(model);
//                    return configurations.stream()
//                            .map(x -> !ev.isValid(x))
//                            .count() * 1.0f / configurations.size();
//
//                })
//                .collect(Collectors.summarizingDouble(x -> x));
//        System.out.println(collect);

        List<VariabilityModel> models1 = models.stream()
                .map(model -> new ScadConfigurationEvaluator(OPENSCAD_PATH, SLIC3R_PATH, SCAD_FILES_ROOT.resolve(model.getName()), model, -1))
                .collect(Collectors.toList());

        System.out.println("features stats : " + models1.stream().collect(Collectors.summarizingInt(x -> x.features().size())));

        System.out.println("constraints stats : " + models1.stream().collect(Collectors.summarizingInt(x -> x.constraints().size())));

        System.out.println("features counts : " + models1.stream().collect(Collectors.groupingBy(x -> x.features().size(), Collectors.counting())));

        List<SampleGenerator> generators = Collections.singletonList(sampleGenerator1);

        System.out.println(">evaluating");
        Results results = TrainingEvaluator.evaluateMany(models1, classifiers, generators, sampleGenerator2);

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

    private static boolean isModelComplete(VariabilityModel model, CombinatorialSampleGenerator c) {
        ScadConfigurationEvaluator ev = new ScadConfigurationEvaluator(OPENSCAD_PATH, SLIC3R_PATH, SCAD_FILES_ROOT.resolve(model.getName()), model, -1);

        try {
            c.generateSamples(model, x -> {
                if(!ev.isCached(x))
                    throw new RuntimeException("BREAK");
            });
            return true;
        } catch (RuntimeException e) {
            return false;
        }
    }

    public static double estimateDomainSize(VariabilityModel model, double rangePartition) {
        double count = 1;
        for (FeatureId f : model.features()) {
            FeatureDomain d = model.getDomain(f);
            if (d instanceof FeatureDomain.Nominal)
                count *= ((FeatureDomain.Nominal) d).getValues().size();
            else if (d instanceof FeatureDomain.Numeric) {
                count *= rangePartition;
            }
        }
        return count;

    }

    private static Stream<Path> listFiles(Path path) {
        try {
            return Files.list(path);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private static Stream<Path> listAllScadFiles() {
        return listFiles(SCAD_FILES_ROOT)
                .flatMap(ScadModelsGeneratedTrainer::listFiles)
                .filter(x -> x.getFileName().toString().endsWith(".scad"));
    }

    private static Optional<VariabilityModel> loadJson(Path path) {
        try {
            return Optional.of(ScadModelLoader.load(path.toFile()));
        } catch (ScadModelLoader.UnhandledTypeException e) {
//            System.out.println("Failed to load " + path + " -> " + e.getMessage());
            return Optional.empty();
        } catch (IOException | ParseException e) {
            throw new RuntimeException(e);
        }
    }
}
