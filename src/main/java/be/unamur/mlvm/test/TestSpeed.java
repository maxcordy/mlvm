package be.unamur.mlvm.test;

import be.unamur.mlvm.reasoner.weka.ClassifierFactory;
import be.unamur.mlvm.reasoner.weka.Classifiers;
import be.unamur.mlvm.sampling.CombinatorialSampleGenerator;
import be.unamur.mlvm.sampling.SampleGenerator;
import be.unamur.mlvm.splot.SplotModelLoader;
import be.unamur.mlvm.vm.VariabilityModel;
import fm.FeatureModelException;
import weka.classifiers.trees.RandomTree;

import java.io.PrintStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class TestSpeed {

    private static final String OUTPUT_NAME = "test_speed_xxx_0";
    private static final long LIMIT = 5;

    public static void main(String[] args) throws Exception {
        List<ClassifierFactory> classifiers = Arrays.asList(
//                SVM_Poly[3,2.0,0.5]	RandomForest	SVM_Puk[1.0, 0.1]	RandomCommittee	REPTree	LogisticModelTree	MultilayerPerceptron	J48


        Classifiers.SVM_Poly(3,2,0.5),


                Classifiers.RandomForest(),
                Classifiers.RandomCommittee(),
                Classifiers.REPTree(),
                Classifiers.LogisticModelTree(),
                Classifiers.MultilayerPerceptron(),
                Classifiers.J48()
        );

        Map<Integer, List<VariabilityModel>> models = loadSamplesDirectory("SPLOT")
                .collect(Collectors.groupingBy(x -> x.features().size(), Collectors.toList()));

        System.out.println("Loaded " + models.size() + " models");


        SampleGenerator generator = new CombinatorialSampleGenerator();

        System.out.println(">evaluating");

        try (PrintStream out = new PrintStream("./results/" + OUTPUT_NAME + ".csv")) {


            out.print("features");
            classifiers.forEach(cl -> out.print(';' + cl.getLabel()));
            out.println();

            models.entrySet()
                    .stream().sorted(Comparator.comparing(Map.Entry::getKey))
                    .forEach(entry -> {
                        if(entry.getKey() < 13) return;
                        if(entry.getKey() > 13) return;

                        out.print(entry.getKey());
                        System.out.println("\t\t\t\t\t\t\t\t\t\tLEVEL: " + entry.getKey());

                        for (ClassifierFactory cl : classifiers) {
                            long t = System.currentTimeMillis();
                            entry.getValue().stream()
                                    .limit(LIMIT)
                                    .forEach(m -> {
                                        try {
                                            TrainingEvaluator.evaluate(m, cl, generator, generator);
                                        } catch (FeatureModelException e) {
                                            throw new RuntimeException(e);
                                        }
                                    });
                            RandomTree

                            long d = System.currentTimeMillis() - t;
                            out.printf(";%.3f", d * 0.001 / Math.min(LIMIT, entry.getValue().size()));
                            System.out.println("\t\t\t\t\t\t\t\t\t\t\t" + cl.getLabel() + ": " + (d * 0.001) + "s");
                        }
                        out.println();
                    });

        }
    }

    private static Stream<VariabilityModel> loadSamplesDirectory(String s) throws Exception {
        return Files.list(Paths.get(TestSpeed.class.getResource("/samples/" + s).toURI()))
                .map(TestSpeed::loadFile);
    }

    private static VariabilityModel loadFile(Path x) {
        try {
            return SplotModelLoader.parse(x.toString());
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
