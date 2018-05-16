package be.unamur.mlvm.test.splot;

import be.unamur.mlvm.reasoner.weka.ClassifierFactory;
import be.unamur.mlvm.reasoner.weka.Classifiers;
import be.unamur.mlvm.sampling.CombinatorialSampleGenerator;
import be.unamur.mlvm.sampling.SampleGenerator;
import be.unamur.mlvm.splot.SplotModelLoader;
import be.unamur.mlvm.test.Results;
import be.unamur.mlvm.test.TestUtils;
import be.unamur.mlvm.test.TrainingEvaluator;
import be.unamur.mlvm.vm.ConstraintId;
import be.unamur.mlvm.vm.IndexedVariabilityModel;
import be.unamur.mlvm.vm.VariabilityModel;

import java.io.IOException;
import java.io.PrintStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class TestSplotModels_RemoveX {


    /**
     * Tests various training algorithms with various models, sampling with the full set and then testing it
     * Use real models from SPLOT library with less than 20,000 configurations
     */
    public static void main(String[] args) throws Exception {


        // limite le nombre de modeles ayant le meme nombre de features
        int limit = -1;
//        limit = 10;

        List<ClassifierFactory> classifiers = Arrays.asList(
                Classifiers.SVM_RBF(5),
                Classifiers.SVM_Poly(3, 2, 0.5),
                Classifiers.RandomForest(),
                Classifiers.SVM_Puk(1, 0.1),
                Classifiers.RandomCommittee(),
                Classifiers.REPTree(),
                Classifiers.LogisticModelTree(),
                Classifiers.MultilayerPerceptron(),
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


        List<SampleGenerator> generators = Collections.singletonList(new CombinatorialSampleGenerator());

        System.out.println("Loaded " + models.size() + " models");

        Results r[] = new Results[15];
        for (int features = 0; features <= 21; features++)
            for (int remove = 15; remove > 0; remove--) {
                String filename, filename2;
                if (limit >= 0) {
                    filename = "l" + limit + "_F" + features + "_R" + remove;
                    filename2 = "l" + limit + "_upToF" + features + "_R" + remove;
                } else {
                    filename = "F" + features + "_R" + remove;
                    filename2 = "upToF" + features + "_R" + remove;
                }

                filename = "removing/" + filename;
                filename2 = "removing/" + filename2;


                int finalFeatures = features;
                int finalRemove = remove;
                Stream<VariabilityModel> modelsStream = models.stream()
                        .filter(x -> x.features().size() == finalFeatures)
                        .filter(x -> x.constraints().size() > finalRemove);

                if (limit >= 0)
                    modelsStream = modelsStream.limit(limit);

                List<VariabilityModel> models1 = modelsStream
                        .collect(Collectors.toList());

                if (models1.isEmpty())
                    continue;

                List<VariabilityModel> models2 = new ArrayList<>();
                // rotating the constraints to produce different models
                for (VariabilityModel model : models1) {
                    models2.add(model);
                    IndexedVariabilityModel lastModel = (IndexedVariabilityModel) model;
                    for (ConstraintId removal : model.constraints()) {
                        lastModel = (IndexedVariabilityModel) lastModel.remove(removal);
                        lastModel.addConstraint(removal, model.getConstraint(removal));
                        // Removing tree constraint ?
                        // if(model.getConstraint(removal) instanceof TreeConstraint)
                        //     continue;
                        models2.add(lastModel);
                    }
                }

                Path resultsPath = Paths.get("results", "splot", filename + "_raw.csv");
                Results r1 = TestUtils.trainOrLoad(resultsPath, features, models1, classifiers, generators, generators.get(0));
                r[remove] = Results.combine(r[remove], r1);
                TestUtils.saveResults(r1, "splot/" + filename);
                TestUtils.saveResults(r[remove], "splot/" + filename2);
            }
    }
}
