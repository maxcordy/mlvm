package be.unamur.mlvm.test;

import be.unamur.mlvm.evaluator.EvaluationResult;
import be.unamur.mlvm.reasoner.weka.ClassifierFactory;
import be.unamur.mlvm.reasoner.weka.Classifiers;
import be.unamur.mlvm.sampling.CombinatorialSampleGenerator;
import be.unamur.mlvm.sampling.SampleGenerator;
import be.unamur.mlvm.splot.SplotModelLoader;
import be.unamur.mlvm.test.Results;
import be.unamur.mlvm.test.TrainingEvaluator;
import be.unamur.mlvm.test.scad.ScadModelsGeneratedTrainer;
import be.unamur.mlvm.test.scad.ScadModelsResultsGenerator;
import be.unamur.mlvm.test.splot.SplotUtils;
import be.unamur.mlvm.test.splot.TestSplotModels;
import be.unamur.mlvm.vm.VariabilityModel;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class UpdateStats {

    public static void main(String[] args) throws Exception {

        List<VariabilityModel> models = ScadModelsGeneratedTrainer.listAllScadFiles()
                .map(ScadModelsResultsGenerator::loadJson)
                .flatMap(o -> o.map(Stream::of).orElseGet(Stream::empty))
                .collect(Collectors.toList());

        System.out.println("Scad models loaded");

        SplotUtils.loadSamplesDirectory("SPLOT")
                .forEach(models::add);

//        Map<String, List<VariabilityModel>> models1 = models.stream()
//                .collect(Collectors.groupingBy(VariabilityModel::getName));
//
//        models1.forEach((k, v) -> {
//            if (v.size() > 1) {
//                System.out.println("Multiple models with same name : " + k);
//                v.forEach(vm -> {
//                    System.out.println("\tF=" + vm.features().size() + ", C=" + vm.constraints().size());
//                });
//
//
//            }
//        });

        System.out.println("SPLOT models loaded");

        Files.list(Paths.get("results"))
                .filter(x -> x.toString().endsWith("_raw.csv"))
                .forEach(file -> {
                    Results r = loadResults(file, models);
//                    try {
//                        saveResults(r, file.toString().replaceAll("_raw\\.csv$", ""));
//                    } catch (IOException e) {
//                        e.printStackTrace();
//                    }
//                    System.out.println(file.toString().replaceAll("_raw\\.csv$", ""));
                });


    }

    private static Results loadResults(Path path, List<VariabilityModel> models) {
        ArrayList<TrainingEvaluator.MultiEvaluationResult> results = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(path.toFile()))) {
            String line = reader.readLine();
            while ((line = reader.readLine()) != null) {
                String[] split = line.split(";");

                String classifier = split[0];
                String generator = split[1];

                List<VariabilityModel> models1 = models.stream().filter(x -> x.getName().equals(split[2])).collect(Collectors.toList());

                if (models1.size() > 1) {
                    String filename = path.getFileName().toString();

                    Pattern p1 = Pattern.compile("^test_([0-9]+)_removeRot_([0-9]+)_raw\\.csv$");
                    Matcher m1 = p1.matcher(filename);
                    if (m1.matches()) {
                        int f = Integer.parseInt(m1.group(1));
                        models1.removeIf(x -> (1 << x.features().size()) > f);
                        int c = Integer.parseInt(m1.group(2));
                        models1.removeIf(x -> (1 << x.constraints().size()) < c);
                    }

                    if (models1.size() > 1) {

                        models1.forEach(vm -> {
                            System.out.println("\tF=" + vm.features().size() + ", C=" + vm.constraints().size());
                        });

                        throw new RuntimeException("Multiple models found for " + split[2] + " in file " + path);
                    }
                }
                if (models1.isEmpty())
                    throw new RuntimeException("Model not found for " + split[2] + " in file " + path);


                results.add(new TrainingEvaluator.MultiEvaluationResult(models.get(0), classifier, generator, -1,
                        new EvaluationResult(Integer.parseInt(split[3]), Integer.parseInt(split[4]), Integer.parseInt(split[5]), Integer.parseInt(split[6]))));

            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return new Results(results);
    }

    private static void saveResults(Results results, String outName) throws IOException {
        try (PrintStream out = new PrintStream(outName + "_stats.csv")) {
            results.displayStats(out);
        }
        try (PrintStream out = new PrintStream(outName + "_cross.csv")) {
            results.displayScoreVsConstraints(out);
        }
        try (PrintStream out = new PrintStream(outName + "_raw.csv")) {
            results.displayRawResults(out);
        }
    }

}
