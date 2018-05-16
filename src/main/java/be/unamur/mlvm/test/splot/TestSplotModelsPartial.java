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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class TestSplotModelsPartial {

    public static void main(String[] args) throws Exception {

        // limite le nombre de modeles ayant le meme nombre de features
        int limit = -1;
        limit = 5;

        List<ClassifierFactory> classifiers = Arrays.asList(
//                Classifiers.SVM_RBF(5),
                Classifiers.SVM_Poly(3, 2, 0.5),
                Classifiers.RandomForest(),
//                Classifiers.SVM_Puk(1, 0.1),
                Classifiers.RandomCommittee(),
                Classifiers.REPTree(),
                Classifiers.LogisticModelTree(),
//                Classifiers.MultilayerPerceptron(),
                Classifiers.J48(),
                Classifiers.NaiveBayesUpdateable(),
                Classifiers.HoeffdingTree(),
//                Classifiers.IBk(),
//                Classifiers.KStar(),
                Classifiers.StochasticGradientDescend()
//                Classifiers.LWL()

        );

        List<VariabilityModel> models = new ArrayList<>();

        SplotUtils.loadSamplesDirectory("SPLOT")
                .forEach(models::add);

        System.out.println("Loaded " + models.size() + " models");

        double[] partials = new double[]{0.01, 0.005};
        Results r[] = new Results[partials.length];

        for (int features = 21; features <= 30; features++)
            for (int partialId = 0; partialId < partials.length; partialId++) {
                double partial = partials[partialId];

                String filename = "F" + features;
                String filename2 = "upToF" + features;
                if (limit >= 0) {
                    filename = "l" + limit + "_" + filename;
                    filename2 = "l" + limit + "_" + filename2;
                }
                filename = String.format("partial_big/P%f_%s", partial, filename);
                filename2 = String.format("partial_big/P%f_%s", partial, filename2);

                List<SampleGenerator> generators = Arrays.asList(
                        new RandomSampleGenerator(partial, true),
                        new RandomSampleGenerator(partial, true)
                );


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
                r[partialId] = Results.combine(r[partialId], r1);
                TestUtils.saveResults(r1, "splot/" + filename);
                TestUtils.saveResults(r[partialId], "splot/" + filename2);
            }
    }
}
