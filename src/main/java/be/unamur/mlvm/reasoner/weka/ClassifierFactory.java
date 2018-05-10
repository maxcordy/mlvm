package be.unamur.mlvm.reasoner.weka;

import weka.classifiers.Classifier;
import weka.core.Instances;

public interface ClassifierFactory {
    String getLabel();
    Classifier create(Instances trainingSet) throws Exception;
}
