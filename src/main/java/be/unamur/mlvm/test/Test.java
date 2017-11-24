package be.unamur.mlvm.test;

import be.unamur.mlvm.evaluator.EvaluationResult;
import be.unamur.mlvm.evaluator.LearningModelEvaluator;
import be.unamur.mlvm.reasoner.weka.BooleanFeatureHandler;
import be.unamur.mlvm.reasoner.weka.Classifiers;
import be.unamur.mlvm.reasoner.weka.WekaLearningModel;
import be.unamur.mlvm.vm.*;

import java.util.*;
import java.util.function.Predicate;

public class Test {
    private static Random random = new Random();

    public static void main(String[] args) {

        System.out.println("Generating data");
        VariabilityModel testModel = createTestModel();

        LearningModelEvaluator ev = new LearningModelEvaluator(
                capacity -> new WekaLearningModel(testModel, Classifiers.SVM(), new BooleanFeatureHandler(), capacity),
                testModel, testModel);


        ArrayList<Configuration> samples = new ArrayList<>();
        for (int i = 0; i < 100; i++)
            samples.add(new MockConfiguration(generateRandomValues(testModel.features())));

        System.out.println("Evaluation");
        EvaluationResult res = ev.crossValidateKFold(samples, 2);

        System.out.println("Results");
        System.out.println(" Precision: " + res.getPrecision());
        System.out.println(" Recall: " + res.getRecall());
        System.out.println(" F-Score: " + res.getFScore());
    }

    private static VariabilityModel createTestModel() {
        FeatureId f1 = new FeatureId("Feature #1");
        FeatureId f2 = new FeatureId("Feature #2");
        FeatureId f3 = new FeatureId("Feature #3");
        FeatureId f4 = new FeatureId("Feature #4");

        Map<ConstraintId, Predicate<Configuration>> constraints = new HashMap<>();
        constraints.put(new ConstraintId("f1 => f3"), c -> !v(c, f1) || v(c, f2));
        constraints.put(new ConstraintId("f3 xor f4"), c -> v(c, f3) != v(c, f4));

        return new MockVariabilityModel(new HashSet<>(Arrays.asList(f1, f2, f3, f4)), constraints);
    }

    private static Map<FeatureId, FeatureValue> generateRandomValues(Set<FeatureId> features) {
        Map<FeatureId, FeatureValue> m = new HashMap<>();
        features.forEach(f -> m.put(f, FeatureValue.parse("" + random.nextBoolean())));
        return m;
    }

    private static boolean v(Configuration c, FeatureId f) {
        return c.valueOf(f).asBool();
    }
}