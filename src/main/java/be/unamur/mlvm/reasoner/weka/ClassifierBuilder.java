package be.unamur.mlvm.reasoner.weka;

import weka.classifiers.Classifier;
import weka.core.Instance;
import weka.core.Instances;

public interface ClassifierBuilder {

    void initialize(Instances instances) throws Exception;

    void train(Instance instance) throws Exception;

    Classifier build() throws Exception;
}
