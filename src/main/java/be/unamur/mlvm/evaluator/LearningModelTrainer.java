package be.unamur.mlvm.evaluator;

import be.unamur.mlvm.reasoner.LearningModel;
import be.unamur.mlvm.reasoner.LearningModelFactory;
import be.unamur.mlvm.reasoner.Oracle;
import be.unamur.mlvm.sampling.SampleGenerator;
import be.unamur.mlvm.vm.Configuration;

public class LearningModelTrainer implements SampleGenerator.SamplesConsumer
{
    private final Oracle trainingOracle;
    private LearningModelFactory factory;
    private LearningModel learningModel;

    public LearningModelTrainer(Oracle trainingOracle, LearningModelFactory factory) {
        this.trainingOracle = trainingOracle;
        this.factory = factory;
    }


    @Override
    public void initialize(int samplesCount) {
        this.learningModel = factory.create(samplesCount);
    }

    @Override
    public void consume(Configuration configuration) {
        this.learningModel.train(configuration, trainingOracle.isValid(configuration));
    }

    public LearningModel getLearningModel() {
        return this.learningModel;
    }
}



