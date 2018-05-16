package be.unamur.mlvm.sampling;

import be.unamur.mlvm.reasoner.Oracle;
import be.unamur.mlvm.vm.*;

import java.util.List;
import java.util.Random;

public class UnbalancedRandomSampleGenerator implements SampleGenerator {
    private static final double DEFAULT_MIN_VALUE = -1000;
    private static final double DEFAULT_MAX_VALUE = 1000;
    private Random random = new Random();
    private final Oracle validator;
    private double ratio;
    private final int numericValues;

    public UnbalancedRandomSampleGenerator(Oracle validator, double ratio) {
        this.validator = validator;
        this.ratio = ratio;
        this.numericValues = 0;
    }

    public UnbalancedRandomSampleGenerator(Oracle validator, double ratio, int numericValues) {
        this.validator = validator;
        this.ratio = ratio;
        this.numericValues = numericValues;
    }

    @Override
    public String getLabel() {
        return "UnbalancedRandom[" + ratio + "]";
    }

    @Override
    public void generateSamples(VariabilityModel model, SamplesConsumer consumer) {
        CombinatorialSampleGenerator c = new CombinatorialSampleGenerator(numericValues);
        c.generateSamples(model, new FilterConsumer(consumer));
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

            if (random.nextDouble() < inclusionProbability || validator.isValid(configuration)) {
                consumer.consume(configuration);
                remainingPartial--;
            }
            remainingTotal--;
        }
    }
}
