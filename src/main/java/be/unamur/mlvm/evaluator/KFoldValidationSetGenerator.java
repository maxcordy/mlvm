package be.unamur.mlvm.evaluator;

import be.unamur.mlvm.sampling.SampleGenerator;
import be.unamur.mlvm.vm.Configuration;
import be.unamur.mlvm.vm.VariabilityModel;

import java.util.List;

class KFoldValidationSetGenerator implements SampleGenerator {
    private final List<Configuration> dataSet;
    private final int folds;
    private final int index;

    KFoldValidationSetGenerator(List<Configuration> dataSet, int folds, int index) {
        this.dataSet = dataSet;
        this.folds = folds;
        this.index = index;
    }

    @Override
    public String getLabel() {
        return "KFoldValidationSetGenerator[" + folds + "/" + index + "]";
    }

    @Override
    public void generateSamples(VariabilityModel model, SamplesConsumer consumer) {
        int from = index * dataSet.size() / folds;
        int to = (index + 1) * dataSet.size() / folds;

        consumer.initialize(to - from);

        for (int i = from; i < to; i++)
            consumer.consume(dataSet.get(i));
    }
}
