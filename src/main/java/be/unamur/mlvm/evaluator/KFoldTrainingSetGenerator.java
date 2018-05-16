package be.unamur.mlvm.evaluator;

import be.unamur.mlvm.sampling.SampleGenerator;
import be.unamur.mlvm.vm.Configuration;
import be.unamur.mlvm.vm.VariabilityModel;

import java.util.List;

class KFoldTrainingSetGenerator implements SampleGenerator {
    private final List<Configuration> dataSet;
    private final int folds;
    private final int index;

    KFoldTrainingSetGenerator(List<Configuration> dataSet, int folds, int index) {
        this.dataSet = dataSet;
        this.folds = folds;
        this.index = index;
    }

    @Override
    public String getLabel() {
        return "KFoldTrainingSetGenerator[" + folds + "/" + index + "]";
    }

    @Override
    public void generateSamples(VariabilityModel model, SamplesConsumer consumer) {
        int from = index * dataSet.size() / folds;
        int to = (index + 1) * dataSet.size() / folds;

        consumer.initialize(dataSet.size() - (to - from));

        for (int i = 0; i < from; i++)
            consumer.consume(dataSet.get(i));
        for (int i = to; i < dataSet.size(); i++)
            consumer.consume(dataSet.get(i));
    }
}
