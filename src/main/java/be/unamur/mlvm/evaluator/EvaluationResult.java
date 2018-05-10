package be.unamur.mlvm.evaluator;

import java.util.stream.Stream;

public class EvaluationResult {
    private int tp, tn, fp, fn;

    public int getTp() {
        return tp;
    }

    public int getTn() {
        return tn;
    }

    public int getFp() {
        return fp;
    }

    public int getFn() {
        return fn;
    }

    public void add(TestResult r) {
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
    }

    public int getCount() {
        return tp + fp + tn + fn;
    }

    public int getRelevantResults() {
        return tp + fn;
    }

    public int GetIrrelevantResults() {
        return tn + fp;
    }

    public int getPositiveResults() {
        return tp + fp;
    }

    public int getNegativeResults() {
        return fp + fn;
    }

    public double getPrecision() {
        int positiveResults = getPositiveResults();
        return positiveResults == 0 ? Double.NaN : tp / ((double) positiveResults);
    }

    public double getRecall() {
        int relevantResults = getRelevantResults();
        return relevantResults == 0 ? Double.NaN : tp / ((double) relevantResults);
    }

    public double getFScore() {
        double p = getPrecision();
        double r = getRecall();
        return 2.0 * p * r / (p + r);
    }

    @Override
    public String toString() {
        return String.format("TP=%4d FP=%4d FN=%4d TN=%4d\nPrc=%.2f   Rcl=%.2f   Fsc=%.2f", tp, fp, fn, tn, getPrecision(), getRecall(), getFScore());
    }

    public EvaluationResult mergeWith(EvaluationResult b) {
        tp += b.tp;
        tn += b.tn;
        fp += b.fp;
        fn += b.fn;
        return this;
    }
}
