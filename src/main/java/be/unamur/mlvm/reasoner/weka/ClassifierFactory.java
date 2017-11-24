package be.unamur.mlvm.reasoner.weka;

import weka.classifiers.Classifier;
import weka.core.Instances;

@FunctionalInterface
public interface ClassifierFactory {
    Classifier create(Instances trainingSet) throws Exception;
}
