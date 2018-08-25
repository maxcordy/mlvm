package be.unamur.mlvm.test.splot;

import be.unamur.mlvm.evaluator.EvaluationResult;
import be.unamur.mlvm.reasoner.weka.ClassifierFactory;
import be.unamur.mlvm.reasoner.weka.Classifiers;
import be.unamur.mlvm.sampling.CombinatorialSampleGenerator;
import be.unamur.mlvm.sampling.RandomSampleGenerator;
import be.unamur.mlvm.sampling.SampleGenerator;
import be.unamur.mlvm.splot.SplotModelLoader;
import be.unamur.mlvm.test.Results;
import be.unamur.mlvm.test.TestUtils;
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

public class TestSplotModelsPartial {

    public static void main(String[] args) throws Exception {

        // limite le nombre de modeles ayant le meme nombre de features
        int limit = 5;
//        int limit = 10;

        List<ClassifierFactory> classifiers = Arrays.asList(
//                Classifiers.MultilayerPerceptron("a"),
//                Classifiers.MultilayerPerceptron("i"),
//                Classifiers.MultilayerPerceptron("i,o"),
//                Classifiers.MultilayerPerceptron("i,a"),
//                Classifiers.MultilayerPerceptron("i,6"),
//                Classifiers.MultilayerPerceptron("a,4")


//                Classifiers.SVM_RBF(5),
//                Classifiers.LogisticRegression(),
//                Classifiers.SVM_Poly(3, 2, 0.5),
                Classifiers.RandomForest(),
//                Classifiers.SVM_Puk(1, 0.1)
                Classifiers.RandomCommittee(),
//                Classifiers.REPTree()
//                Classifiers.LogisticModelTree(),
//                Classifiers.MultilayerPerceptron(),
//                Classifiers.J48()


//                Classifiers.NaiveBayesUpdateable(),
//                Classifiers.HoeffdingTree(),
//                Classifiers.IBk(),
                Classifiers.PART(),
                Classifiers.JRip()
//                Classifiers.KStar(),
//                Classifiers.StochasticGradientDescend(),
//                Classifiers.LWL()

        );

        List<VariabilityModel> models = new ArrayList<>();

        SplotUtils.loadSamplesDirectory("SPLOT")
                .forEach(models::add);

        System.out.println("Loaded " + models.size() + " models");

        int[] partials = new int[]{10, 5};
//        int[] partials = new int[]{5, 50, 200};
        Results r[] = new Results[201];


        for (int features = 26; features <= 30; features+=2)
            for (int partial : partials) {


                String filename = "F" + features;
                String filename2 = "upToF" + features;
                if (limit >= 0) {
                    filename = "l" + limit + "_" + filename;
                    filename2 = "l" + limit + "_" + filename2;
                }
                filename = String.format("new/partial_big/D_P%03d_%s", partial, filename);
                filename2 = String.format("new/partial_big/D_P%03d_%s", partial, filename2);

                List<SampleGenerator> generators =
                        Arrays.asList(
                                new RandomSampleGenerator(partial * 0.001, true),
                                new RandomSampleGenerator(partial * 0.001, true),
                                new RandomSampleGenerator(partial * 0.001, true),
                                new RandomSampleGenerator(partial * 0.001, true),
                                new RandomSampleGenerator(partial * 0.001, true));


                int finalI = features;
                Stream<VariabilityModel> modelsStream = models.stream()
                        .filter(x -> x.features().size() == finalI);
                if (limit >= 0)
                    modelsStream = modelsStream.limit(limit);

                List<VariabilityModel> models1 = modelsStream
                        .collect(Collectors.toList());

                if (models1.isEmpty())
                    continue;

                Path resultsPath = Paths.get("results", "splot", filename + "_raw.csv");
                Results r1 = TestUtils.trainOrLoad(resultsPath, features, models1, classifiers, generators, new CombinatorialSampleGenerator());
                r[partial] = Results.combine(r[partial], r1);
                TestUtils.saveResults(r1, "splot/" + filename);
                TestUtils.saveResults(r[partial], "splot/" + filename2);
            }
    }
}
