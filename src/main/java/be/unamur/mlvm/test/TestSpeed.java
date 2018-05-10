package be.unamur.mlvm.test;

import be.unamur.mlvm.reasoner.weka.ClassifierFactory;
import be.unamur.mlvm.reasoner.weka.Classifiers;
import be.unamur.mlvm.sampling.CombinatorialSampleGenerator;
import be.unamur.mlvm.sampling.SampleGenerator;
import be.unamur.mlvm.splot.SplotModelLoader;
import be.unamur.mlvm.vm.VariabilityModel;

import java.io.PrintStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class TestSpeed {

    private static final String OUTPUT_NAME = "test_speed";
    private static final int MAX = 20000;

    public static void main(String[] args) throws Exception {
        List<ClassifierFactory> classifiers = Arrays.asList(
                Classifiers.SVM_Poly(3, 2, 0.5),
                Classifiers.RandomForest(),
                Classifiers.SVM_Puk(1, 0.1),
                Classifiers.RandomCommittee(),
                Classifiers.REPTree(),
                Classifiers.LogisticModelTree(),
                Classifiers.MultilayerPerceptron(),
                Classifiers.J48(),
                Classifiers.SVM_RBF(5)
        );


        List<VariabilityModel> models = new ArrayList<>();

        loadSamplesDirectory("SPLOT")
                .forEach(models::add);

        System.out.println("Loaded " + models.size() + " models");
        System.out.println("Removing models with configurations > " + MAX);
        models.removeIf(x -> Math.pow(2, x.features().size()) > MAX);

        System.out.println("features stats : " + models.stream().collect(Collectors.summarizingInt(x -> x.features().size())));

        System.out.println("constraints stats : " + models.stream().collect(Collectors.summarizingInt(x -> x.constraints().size())));

        SampleGenerator generator = new CombinatorialSampleGenerator();

        Map<Integer, List<VariabilityModel>> modelsByFeatures = models.stream().collect(Collectors.groupingBy(x -> x.features().size(), Collectors.toList()));

        System.out.println(">evaluating");

        try (PrintStream out = new PrintStream("./results/" + OUTPUT_NAME + ".csv")) {


            out.print("features");
            classifiers.forEach(cl -> out.print(';' + cl.getLabel()));
            out.println();
            ArrayList<Integer> featuresCounts = new ArrayList<>(modelsByFeatures.keySet());
            featuresCounts.sort(Integer::compareTo);
            for (Integer x : featuresCounts) {
                List<VariabilityModel> modelsWithXFeatures = modelsByFeatures.get(x);

                out.print(x);
                System.out.println("\t\t\t\t\t\t\t\t\t\tLEVEL: " + x);

                for (ClassifierFactory cl : classifiers) {
                    long t = System.currentTimeMillis();
                    for (VariabilityModel modelsWithXFeature : modelsWithXFeatures)
                        TrainingEvaluator.evaluate(modelsWithXFeature, cl, generator, generator);


                    long d = System.currentTimeMillis() - t;
                    out.printf(";%.3f", d * 0.001 / modelsWithXFeatures.size());
                    System.out.println("\t\t\t\t\t\t\t\t\t\t\t" + cl.getLabel() + ": " + (d * 0.001) + "s");
                }
                out.println();
            }
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
