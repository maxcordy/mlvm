package be.unamur.mlvm.test;

import be.unamur.mlvm.evaluator.EvaluationResult;
import be.unamur.mlvm.reasoner.weka.ClassifierFactory;
import be.unamur.mlvm.sampling.SampleGenerator;
import be.unamur.mlvm.test.splot.ConstraintRemover;
import be.unamur.mlvm.vm.VariabilityModel;
import fm.FeatureModelException;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.function.Consumer;
import java.util.function.Function;
import java.util.stream.Collectors;

public class TestUtils {


    public static void saveResults(Results results, String outName) {
        try {
            Files.createDirectories(Paths.get("./results/" + outName + "_stats.csv").getParent());
            try (PrintStream out = new PrintStream("./results/" + outName + "_stats.csv")) {
                results.displayStats(out);
            }
//        try (PrintStream out = new PrintStream("./results/" + outName + "_cross.csv")) {
//            results.displayScoreVsConstraints(out);
//        }
            try (PrintStream out = new PrintStream("./results/" + outName + "_raw.csv")) {
                results.displayRawResults(out);
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }


    public static Results loadResults(Path path, List<VariabilityModel> models, int features) {
        ArrayList<TrainingEvaluator.MultiEvaluationResult> results = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(path.toFile()))) {
            String line = reader.readLine();
            while ((line = reader.readLine()) != null) {
                String[] split = line.split(";");


                List<VariabilityModel> model = models.stream().filter(x -> x.getName().equals(split[2])).collect(Collectors.toList());
                if (model.size() > 1) {
                    model.removeIf(x -> x.features().size() != features);
                }

                if (model.isEmpty())
                    throw new RuntimeException("Model not found for " + split[2]);
                else if (model.size() > 1)
                    System.out.println("Warning: Multiple models found for " + split[2] + ", cross will be invalid");

                results.add(new TrainingEvaluator.MultiEvaluationResult(model.get(0), split[0], split[1], -1,
                        new EvaluationResult(Integer.parseInt(split[3]), Integer.parseInt(split[4]), Integer.parseInt(split[5]), Integer.parseInt(split[6]))));

            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return new Results(results);
    }

    public static Results trainOrLoad(Path resultsPath, int features, List<VariabilityModel> models, List<ClassifierFactory> classifiers, List<SampleGenerator> generators, SampleGenerator generator) throws FeatureModelException {
        if (Files.exists(resultsPath)) {
            System.out.println("Loading existing evaluation for [" + resultsPath.getFileName() + "] (F=" + features + ", count=" + models.size() + ")");
            return TestUtils.loadResults(resultsPath, models, features);
        } else {
            System.out.println("Running evaluation for [" + resultsPath.getFileName() + "] (F=" + features + ", count=" + models.size() + ")");
            return TrainingEvaluator.evaluateMany(models, classifiers, generators, generator);
        }

    }

    public static <T> void forEach(Collection<T> collection, Consumer<T> consumer) {
        int p = 0;
        int c = 0;
        long start = System.currentTimeMillis();
        int t = collection.size();
        for (T v : collection) {
            int p1 = (c++ * 100 + t / 2) / t;
            if (p != p1) {
                Duration remaining = Duration.ofMillis((long) ((t - c + 0.0) * (System.currentTimeMillis() - start) / c));
                System.out.print("[");
                for (int i = 0; i < 100; i++)
                    System.out.print(i < p ? '-' : ' ');
                System.out.print("] ");
                System.out.printf("%d%% - Rem: %d:%02d\n", p, remaining.toMinutes(), remaining.getSeconds() % 60);
                p = p1;
            }
            consumer.accept(v);
        }
    }
}
