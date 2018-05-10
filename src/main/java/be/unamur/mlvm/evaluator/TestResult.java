package be.unamur.mlvm.evaluator;

public enum TestResult {
    TruePositive, TrueNegative,
    FalsePositive, FalseNegative;

    final String c;

    TestResult() {
        c = this.name().replaceAll("[a-z]", "");
    }
}
