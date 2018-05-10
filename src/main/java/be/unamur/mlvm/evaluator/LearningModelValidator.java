package be.unamur.mlvm.evaluator;

import be.unamur.mlvm.reasoner.LearningModel;
import be.unamur.mlvm.reasoner.Oracle;
import be.unamur.mlvm.sampling.SampleGenerator;
import be.unamur.mlvm.vm.Configuration;

public class LearningModelValidator implements SampleGenerator.SamplesConsumer {
    private final Oracle validationOracle;
    private final Oracle learnedModel;
    private final EvaluationResult results;

    public LearningModelValidator(Oracle validationOracle, Oracle learnedModel) {
        this.validationOracle = validationOracle;
        this.learnedModel = learnedModel;
        this.results = new EvaluationResult();
    }

    @Override
    public void consume(Configuration configuration) {
        results.add(compareResults(learnedModel.isValid(configuration), validationOracle.isValid(configuration)));
    }


    private static TestResult compareResults(boolean predicted, boolean expected) {
        if (predicted) {
            return expected ? TestResult.TruePositive : TestResult.FalsePositive;
        } else {
            return expected ? TestResult.FalseNegative : TestResult.TrueNegative;
        }
    }

    public EvaluationResult getResults() {
        return results;
    }
}
