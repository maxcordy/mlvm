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
                        result.classifier, result.generator, result.model.getName(),
                        result.result.getTp(), result.result.getFp(), result.result.getFn(), result.result.getTn(),
                        result.result.getPrecision(), result.result.getRecall(), result.result.getFScore()
                ));
    }

    public void displayStats(PrintStream out) {
        displayStats(out, "CLASSIFIER", x -> x.classifier);
        out.println();
        DoubleSummaryStatistics validityRatioStats = results.stream()
                .collect(Collectors.summarizingDouble(x -> x.result.getRelevantResults() * 1.0 / x.result.getCount()));

        DoubleSummaryStatistics validityRatioStatsF = results.stream()
                .filter(x -> Double.isFinite(x.result.getFScore()))
                .collect(Collectors.summarizingDouble(x -> x.result.getRelevantResults() * 1.0 / x.result.getCount()));
        out.println();
        out.println("VALIDITY RATIO;(F)");
        out.printf("min;%f\n", validityRatioStats.getMin(), validityRatioStatsF.getMin());
        out.printf("avg;%f\n", validityRatioStats.getAverage(), validityRatioStatsF.getAverage());
        out.printf("max;%f\n", validityRatioStats.getMax(), validityRatioStatsF.getMax());
        out.println();

        displayStats(out, "GENERATOR", x -> x.generator);
        out.println();
        displayStats(out, "MODEL", x -> x.model.getName());
    }

    public void displayScoreVsConstraints(PrintStream out) {

        out.print("Constraints;Count");

        List<String> classifiers = new ArrayList<>(results.stream().map(x -> x.classifier).collect(Collectors.toSet()));
        classifiers.forEach(x -> {
            out.print(";" + x + "_min");
            out.print(";" + x + "_Q1");
            out.print(";" + x + "_Q2");
            out.print(";" + x + "_Q3");
            out.print(";" + x + "_max");
        });
        out.println();


        ArrayList<Map.Entry<Integer, Map<String, List<TrainingEvaluator.MultiEvaluationResult>>>> models_x_classifier =
                new ArrayList<>(
                        results.stream().collect(
                                Collectors.groupingBy(x -> (x.model.constraints().size() - 1),
                                        Collectors.groupingBy(y -> y.classifier)
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
        out.printf("%s;PRECISION;RECALL;F-SCORE;VALID_RATIO;COUNT;PRECISION(F);RECALL(F);F-SCORE(F);VALID_RATIO(F);COUNT(F)\n", label);

        Map<String, FilteredStats> stats = results.stream()
                .collect(Collectors.groupingBy(grouping, summarizingAll()));

        stats.forEach((lineLabel, lineStats) ->
                out.printf(
                        "%s;%.3f;%.3f;%.3f;%.3f;%d;%.3f;%.3f;%.3f;%.3f;%d\n",
                        lineLabel,
                        lineStats.unfiltered.precision.getAverage(),
                        lineStats.unfiltered.recall.getAverage(),
                        lineStats.unfiltered.fscore.getAverage(),
                        lineStats.unfiltered.vratio.getAverage(),
                        lineStats.unfiltered.vratio.getCount(),
                        lineStats.filtered.precision.getAverage(),
                        lineStats.filtered.recall.getAverage(),
                        lineStats.filtered.fscore.getAverage(),
                        lineStats.filtered.vratio.getAverage(),
                        lineStats.filtered.vratio.getCount()
                ));
    }

    private static Collector<TrainingEvaluator.MultiEvaluationResult, ?, FilteredStats> summarizingAll() {
        return Collector.of(FilteredStats::new, FilteredStats::accept, FilteredStats::combine);
    }

    public static Results combine(Results r, Results r1) {
        if(r == null)
            return r1;
        ArrayList<TrainingEvaluator.MultiEvaluationResult> l = new ArrayList<>(r.results.size() + r1.results.size());
        l.addAll(r.results);
        l.addAll(r1.results);
        return new Results(l);
    }

    public void addResult(TrainingEvaluator.MultiEvaluationResult v) {
        results.add(v);
    }

    private static class Stats {
        private DoubleSummaryStatistics precision = new DoubleSummaryStatistics();
        private DoubleSummaryStatistics recall = new DoubleSummaryStatistics();
        private DoubleSummaryStatistics fscore = new DoubleSummaryStatistics();
        private DoubleSummaryStatistics vratio = new DoubleSummaryStatistics();

        void accept(TrainingEvaluator.MultiEvaluationResult t) {
            precision.accept(Double.isFinite(t.result.getPrecision()) ? t.result.getPrecision() : 0);
            recall.accept(t.result.getRecall());
            fscore.accept(Double.isFinite(t.result.getFScore()) ? t.result.getFScore() : 0);
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

    private static class FilteredStats {
        private Stats unfiltered = new Stats();
        private Stats filtered = new Stats();

        void accept(TrainingEvaluator.MultiEvaluationResult t) {
            if (Double.isFinite(t.result.getPrecision()))
                filtered.accept(t);
            unfiltered.accept(t);
        }

        FilteredStats combine(FilteredStats r) {
            filtered = filtered.combine(r.filtered);
            unfiltered = unfiltered.combine(r.unfiltered);
            return this;
        }
    }
}


