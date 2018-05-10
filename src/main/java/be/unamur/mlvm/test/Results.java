package be.unamur.mlvm.test;

import be.unamur.mlvm.reasoner.weka.ClassifierFactory;

import java.io.PrintStream;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collector;
import java.util.stream.Collectors;

public class Results {

    private List<TrainingEvaluator.MultiEvaluationResult> results;

    public Results(List<TrainingEvaluator.MultiEvaluationResult> results) {
        this.results = results;
    }

    public void displayRawResults(PrintStream out) {
        out.println("CLASSIFIER;SAMPLING;MODEL;TP;FP;FN;TN;PRECISION;RECALL;F-SCORE");
        results.forEach(result ->
                out.printf(
                        "%s;%s;%s;%d;%d;%d;%d;%.3f;%.3f;%.3f\n",
                        result.classifierFactory.getLabel(), result.generator.getLabel(), result.model.getName(),
                        result.result.getTp(), result.result.getFp(), result.result.getFn(), result.result.getTn(),
                        result.result.getPrecision(), result.result.getRecall(), result.result.getFScore()
                ));
    }

    public void displayStats(PrintStream out) {
        displayStats(out, "CLASSIFIER", x -> x.classifierFactory.getLabel());
        out.println();
        DoubleSummaryStatistics validityRatioStats = results.stream()
                .filter(x -> Double.isFinite(x.result.getFScore()))
                .collect(Collectors.summarizingDouble(x -> x.result.getRelevantResults() * 1.0 / x.result.getCount()));
        out.println();
        out.println("VALIDITY RATIO");
        out.printf("min;%f\n", validityRatioStats.getMin());
        out.printf("avg;%f\n", validityRatioStats.getAverage());
        out.printf("max;%f\n", validityRatioStats.getMax());
        out.println();

        displayStats(out, "GENERATOR", x -> x.generator.getLabel());
        out.println();
        displayStats(out, "MODEL", x -> x.model.getName());
    }

    public void displayScoreVsConstraints(PrintStream out) {

        out.print("Constraints;Count");

        List<ClassifierFactory> classifiers = new ArrayList<>(results.stream().map(x -> x.classifierFactory).collect(Collectors.toSet()));
        classifiers.forEach(x -> {
            out.print(";" + x.getLabel() + "_min");
            out.print(";" + x.getLabel() + "_Q1");
            out.print(";" + x.getLabel() + "_Q2");
            out.print(";" + x.getLabel() + "_Q3");
            out.print(";" + x.getLabel() + "_max");
        });
        out.println();


        ArrayList<Map.Entry<Integer, Map<ClassifierFactory, List<TrainingEvaluator.MultiEvaluationResult>>>> models_x_classifier =
                new ArrayList<>(
                        results.stream().collect(
                                Collectors.groupingBy(x -> (x.model.constraints().size() - 1),
                                        Collectors.groupingBy(y -> y.classifierFactory)
                                ))
                                .entrySet());

        models_x_classifier.sort(Comparator.comparing(Map.Entry::getKey));

        models_x_classifier.forEach(entry -> {
            out.print(entry.getKey());
            out.print(';');
            out.print(entry.getValue().get(classifiers.get(0)).size());
            classifiers.forEach(x -> {
                double[] values = entry.getValue().get(x)
                        .stream().mapToDouble(y -> y.result.getFScore())
                        .toArray();
                Arrays.sort(values);
                out.printf(";%.3f;%.3f;%.3f;%.3f;%.3f", values[0],
                        getQ1(values),
                        getQ2(values),
                        getQ3(values),
                        values[values.length - 1]);
            });
            out.println();
        });
        out.println();
    }

    private double getMedian(double[] values, int offset, int length) {
        if ((length % 2) == 1)
            return values[offset + length / 2];
        else
            return (values[offset + length / 2 - 1] + values[offset + length / 2]) / 2;
    }

    private double getQ1(double[] values) {
        if (values.length == 1) return values[0];
        return getMedian(values, 0, values.length / 2);
    }

    private double getQ2(double[] values) {
        return getMedian(values, 0, values.length);
    }

    private double getQ3(double[] values) {
        if (values.length == 1) return values[0];
        return getMedian(values, (values.length + 1) / 2, values.length / 2);
    }

    private void displayStats(PrintStream out, String label, Function<TrainingEvaluator.MultiEvaluationResult, String> grouping) {
        out.printf("%s;PRECISION;RECALL;F-SCORE;VALID_RATIO\n", label);

        Map<String, Stats> stats = results.stream()
                .filter(x -> Double.isFinite(x.result.getFScore()))
                .collect(Collectors.groupingBy(grouping, summarizingAll()));

        stats.forEach((lineLabel, lineStats) ->
                out.printf(
                        "%s;%.3f;%.3f;%.3f;%.3f\n",
                        lineLabel,
                        lineStats.precision.getAverage(),
                        lineStats.recall.getAverage(),
                        lineStats.fscore.getAverage(),
                        lineStats.vratio.getAverage()));
    }

    private static Collector<TrainingEvaluator.MultiEvaluationResult, ?, Stats> summarizingAll() {
        return Collector.of(Stats::new, Stats::accept, Stats::combine);
    }

    private static class Stats {
        private DoubleSummaryStatistics precision = new DoubleSummaryStatistics();
        private DoubleSummaryStatistics recall = new DoubleSummaryStatistics();
        private DoubleSummaryStatistics fscore = new DoubleSummaryStatistics();
        private DoubleSummaryStatistics vratio = new DoubleSummaryStatistics();

        void accept(TrainingEvaluator.MultiEvaluationResult t) {
            precision.accept(t.result.getPrecision());
            recall.accept(t.result.getRecall());
            fscore.accept(t.result.getFScore());
            vratio.accept(t.result.getRelevantResults() * 1.0 / t.result.getCount());
        }

        Stats combine(Stats r) {
            precision.combine(r.precision);
            recall.combine(r.recall);
            fscore.combine(r.fscore);
            vratio.combine(r.vratio);
            return this;
        }
    }
}


