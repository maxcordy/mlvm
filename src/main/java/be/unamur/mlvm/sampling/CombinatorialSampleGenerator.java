package be.unamur.mlvm.sampling;

import be.unamur.mlvm.vm.*;

import java.util.*;

public class CombinatorialSampleGenerator implements SampleGenerator {
    private static final double DEFAULT_MIN_VALUE = -1000;
    private static final double DEFAULT_MAX_VALUE = 1000;

    private final int numericValues;

    public CombinatorialSampleGenerator() {
        this.numericValues = 0;
    }

    public CombinatorialSampleGenerator(int numericValues) {
        this.numericValues = numericValues;
    }

    @Override
    public String getLabel() {
        return "Combinatorial[" + numericValues + "]";
    }

    @Override
    public void generateSamples(VariabilityModel model, SamplesConsumer consumer) {
        int modelCapacity = getModelCapacity(model);
        if (modelCapacity == 0) throw new RuntimeException("No numeric value configured");


        FeatureId[] features = model.features().toArray(new FeatureId[0]);
        FeatureValue[][] featureValues = Arrays.stream(features)
                .map(model::getDomain)
                .map(this::generateValues)
                .toArray(FeatureValue[][]::new);

        IndexedConfiguration conf = new IndexedConfiguration(new FeatureValue[model.features().size()]);

        consumer.initialize(modelCapacity);
        combine(consumer, conf, features, featureValues, 0);
    }

    private void combine(SamplesConsumer consumer, IndexedConfiguration conf, FeatureId[] features, FeatureValue[][] featureValues, int i) {
        if(i >= features.length)
            consumer.consume(conf);
        else {
            FeatureValue[] values = featureValues[i];
            for (FeatureValue value : values) {
                conf.setValue(features[i], value);
                combine(consumer, conf, features, featureValues, i + 1);
            }
        }
    }

    private FeatureValue[] generateValues(FeatureDomain domain) {
        if (domain instanceof FeatureDomain.Nominal)
            return ((FeatureDomain.Nominal) domain).getValues().toArray(new FeatureValue[0]);
        else if (domain instanceof FeatureDomain.Numeric) {
            FeatureDomain.Numeric nd = (FeatureDomain.Numeric) domain;

            double min = Double.isFinite(nd.getMin()) ? nd.getMin() : DEFAULT_MIN_VALUE;
            double max = Double.isFinite(nd.getMax()) ? nd.getMax() : DEFAULT_MAX_VALUE;
            FeatureValue[] values = new FeatureValue[numericValues];
            for (int i = 0; i < values.length; i++) {
                values[i] = new FeatureValue(min + (max - min) * (i / (values.length - 1.0)));
            }
            return values;
        }

        throw new RuntimeException("Unknown domain " + domain);
    }

    private int getModelCapacity(VariabilityModel model) {
        return model.features().stream()
                .map(model::getDomain)
                .mapToInt(x -> (x instanceof FeatureDomain.Nominal) ? ((FeatureDomain.Nominal) x).getValues().size() : numericValues)
                .reduce(1, Math::multiplyExact);
    }
}
