package be.unamur.mlvm.test.splot;

import be.unamur.mlvm.evaluator.EvaluationResult;
import be.unamur.mlvm.reasoner.weka.ClassifierFactory;
import be.unamur.mlvm.reasoner.weka.Classifiers;
import be.unamur.mlvm.sampling.CombinatorialSampleGenerator;
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
//                Classifiers.J48(),
                Classifiers.NaiveBayesUpdateable(),
                Classifiers.HoeffdingTree(),
                Classifiers.IBk(),
                Classifiers.KStar(),
                Classifiers.StochasticGradientDescend(),
                Classifiers.LWL()
        );
        List<VariabilityModel> models = new ArrayList<>();

        SplotUtils.loadSamplesDirectory("SPLOT")
                .forEach(models::add);


        List<SampleGenerator> generators = Collections.singletonList(new CombinatorialSampleGenerator());

        System.out.println("Loaded " + models.size() + " models");

        Results r = null;
        for (int features = 0; features <= 21; features++) {
            String filename, filename2;
            if (limit >= 0) {
                filename = "l" + limit + "_F" + features;
                filename2 = "l" + limit + "_upToF" + features;
            } else {
                filename = "F" + features;
                filename2 = "upToF" + features;
            }

            filename = "updatable_" + filename;
            filename2 = "updatable_" + filename2;


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
            Results r1 = TestUtils.trainOrLoad(resultsPath, features, models1, classifiers, generators, generators.get(0));
            r = Results.combine(r, r1);
            TestUtils.saveResults(r1, "splot/" + filename);
            TestUtils.saveResults(r, "splot/" + filename2);
        }
    }
}
