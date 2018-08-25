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
//        limit = 10;

        List<ClassifierFactory> classifiers = Arrays.asList(
//                Classifiers.SVM_Poly(3, 2, 0.5),
//                Classifiers.RandomForest(),
//                Classifiers.RandomCommittee(),
//                Classifiers.REPTree(),
//                Classifiers.LogisticModelTree(),
//                Classifiers.LogisticRegression()
//                Classifiers.J48(),
//                Classifiers.NaiveBayesUpdateable(),
//                Classifiers.StochasticGradientDescend()
//
//                Classifiers.SVM_RBF(5),
//                Classifiers.SVM_RBF(2),
//                Classifiers.SVM_Sigmoid(0.1),
//                Classifiers.SVM_Linear(),
//                Classifiers.SVM_Puk(1, 0.1),
//                Classifiers.HoeffdingTree(),
//                Classifiers.IBk(),
//                Classifiers.KStar(),
//                Classifiers.LWL()

                Classifiers.JRip(),
                Classifiers.PART()
//                Classifiers.ZeroR(),
//                Classifiers.OneR()
        );
        List<VariabilityModel> models = new ArrayList<>();

        SplotUtils.loadSamplesDirectory("SPLOT")
                .forEach(models::add);


        List<SampleGenerator> generators = Collections.singletonList(new CombinatorialSampleGenerator());

        System.out.println("Loaded " + models.size() + " models");

        Results r = null;
        for (int features = 0; features <= 21; features++) {
            String filename, filename2;
            String prefix = "new/E_";

            filename = "F" + features;
            filename2 = "Fto_" + features;


            if (limit >= 0) {
                filename = "l" + limit + "_" + filename;
                filename2 = "l" + limit + "_" + filename2;
            }


            filename = prefix + filename;
            filename2 = prefix + filename2;

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
