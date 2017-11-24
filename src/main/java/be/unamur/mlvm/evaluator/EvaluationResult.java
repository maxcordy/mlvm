package be.unamur.mlvm.evaluator;

import java.util.stream.Stream;

public class EvaluationResult {
    private int tp, tn, fp, fn;

    public EvaluationResult(Stream<TestResult> results) {
        results.forEach(r -> {
            switch (r) {
                case TruePositive:
                    tp++;
                    break;
                case TrueNegative:
                    tn++;
                    break;
                case FalsePositive:
                    fp++;
                    break;
                case FalseNegative:
                    fn++;
                    break;
            }
        });
    }

    public int getCount() {
        return tp + fp + tn + fn;
    }

    public int getPositiveResults() {
        return tp + tn;
    }

    public int getNegativeResults() {
        return fp + fn;
    }

    public double getPrecision() {
        return tp == 0 ? 0 : tp / ((double) tp + fp);
    }

    public double getRecall() {
        return tp == 0 ? 0 : tp / ((double) tp + fn);
    }

    public double getFScore() {
        if(tp == 0) return 0;
        double p = getPrecision();
        double r = getRecall();
        return 2.0 * p * r / (p + r);
    }
}
