package be.unamur.mlvm.sampling;

import be.unamur.mlvm.vm.*;

import java.util.List;
import java.util.Random;

public class RandomSampleGenerator implements SampleGenerator {
    private static final double DEFAULT_MIN_VALUE = -1000;
    private static final double DEFAULT_MAX_VALUE = 1000;
    private Random random = new Random();
    private double ratio;
    private boolean unique;
    private final int numericValues;

    public RandomSampleGenerator(double ratio, boolean unique) {
        this.ratio = ratio;
        this.unique = unique;
        this.numericValues = 0;
    }

    public RandomSampleGenerator(double ratio, boolean unique, int numericValues) {
        this.ratio = ratio;
        this.unique = unique;
        this.numericValues = numericValues;
    }

    @Override
    public String getLabel() {
        return "Random[" + ratio + "]";
    }

    @Override
    public void generateSamples(VariabilityModel model, SamplesConsumer consumer) {
        if (unique) {
            CombinatorialSampleGenerator c = new CombinatorialSampleGenerator(numericValues);
            c.generateSamples(model, new FilterConsumer(consumer));
        } else {
            int count = (int) (ratio * getModelCapacity(model) + 0.5);
            IndexedConfiguration conf = new IndexedConfiguration(new FeatureValue[model.features().size()]);
            consumer.initialize(count);

            while (count-- > 0) {
                model.features().forEach(f -> conf.setValue(f, generateFeature(model.getDomain(f))));
                consumer.consume(conf);
            }

        }
    }

    private FeatureValue generateFeature(FeatureDomain domain) {
        if (domain instanceof FeatureDomain.Nominal) {
            List<FeatureValue> values = ((FeatureDomain.Nominal) domain).getValues();
            return values.get(random.nextInt(values.size()));
        } else if (domain instanceof FeatureDomain.Numeric) {
            FeatureDomain.Numeric nd = (FeatureDomain.Numeric) domain;
            double min = Double.isFinite(nd.getMin()) ? nd.getMin() : DEFAULT_MIN_VALUE;
            double max = Double.isFinite(nd.getMax()) ? nd.getMax() : DEFAULT_MAX_VALUE;
            return new FeatureValue(min + (max - min) * random.nextDouble());
        }

        throw new RuntimeException("Unknown domain " + domain);
    }

    private int getModelCapacity(VariabilityModel model) {
        return model.features().stream()
                .map(model::getDomain)
                .mapToInt(x -> (x instanceof FeatureDomain.Nominal) ? ((FeatureDomain.Nominal) x).getValues().size() : numericValues)
                .reduce(1, Math::multiplyExact);
    }

    private class FilterConsumer implements SamplesConsumer {

        private final SamplesConsumer consumer;
        private int remainingTotal;
        private int remainingPartial;

        FilterConsumer(SamplesConsumer consumer) {
            this.consumer = consumer;
        }

        @Override
        public void initialize(int samplesCount) {
            this.remainingTotal = samplesCount;
            this.remainingPartial = (int) (0.5 + samplesCount * ratio);
            consumer.initialize(this.remainingPartial);
        }

        @Override
        public void consume(Configuration configuration) {
            double inclusionProbability = remainingPartial * 1.0 / remainingTotal;
            if (random.nextDouble() < inclusionProbability) {
                consumer.consume(configuration);
                remainingPartial--;
            }
            remainingTotal--;
        }
    }
}
