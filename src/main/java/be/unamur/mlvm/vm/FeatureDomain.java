package be.unamur.mlvm.vm;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;

public class FeatureDomain {
    private FeatureDomain() {
    }


    public static class Nominal extends FeatureDomain {
        private final List<FeatureValue> values;

        public Nominal(FeatureValue... values) {
            this.values = new ArrayList<>(new HashSet<>(Arrays.asList(values)));
        }

        public List<FeatureValue> getValues() {
            return values;
        }
    }


    public static class Numeric extends FeatureDomain {
        private final double min;
        private final double max;

        public Numeric() {
            this(Double.NEGATIVE_INFINITY, Double.POSITIVE_INFINITY);
        }

        public Numeric(double min, double max) {
            this.min = min;
            this.max = max;
        }

        public double getMin() {
            return min;
        }

        public double getMax() {
            return max;
        }
    }
}