package be.unamur.mlvm.sampling;

import be.unamur.mlvm.vm.Configuration;
import be.unamur.mlvm.vm.VariabilityModel;


import java.util.List;

public interface SampleGenerator {
    String getLabel();

    void generateSamples(VariabilityModel model, SamplesConsumer consumer);

    @FunctionalInterface
    interface SamplesConsumer {
        default void initialize(int samplesCount) {}

        void consume(Configuration configuration);
    }
}