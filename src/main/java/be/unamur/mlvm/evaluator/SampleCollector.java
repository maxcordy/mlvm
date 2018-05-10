package be.unamur.mlvm.evaluator;

import be.unamur.mlvm.sampling.SampleGenerator;
import be.unamur.mlvm.vm.Configuration;
import be.unamur.mlvm.vm.VariabilityModel;

import java.util.ArrayList;
import java.util.List;

class SampleCollector implements SampleGenerator.SamplesConsumer {


    private ArrayList<Configuration> samples;

    @Override
    public void initialize(int samplesCount) {
        this.samples = new ArrayList<Configuration>(samplesCount);
    }

    @Override
    public void consume(Configuration configuration) {
        this.samples.add(configuration.clone());
    }

    public ArrayList<Configuration> getSamples() {
        return samples;
    }

    public static List<Configuration> collect(VariabilityModel model, SampleGenerator generator) {
        SampleCollector collector = new SampleCollector();
        generator.generateSamples(model, collector);
        return collector.getSamples();
    }
}
