package be.unamur.mlvm.reasoner.weka;


import weka.classifiers.functions.SMO;
import weka.classifiers.functions.supportVector.PolyKernel;
import weka.classifiers.trees.J48;

public class Classifiers {


    public static ClassifierFactory J48() {
        return instances -> {
            J48 classifier = new J48();
            classifier.buildClassifier(instances);
            return classifier;
        };
    }

    public static ClassifierFactory SVM() {
        return instances -> {
            SMO classifier = new SMO();
            classifier.buildClassifier(instances);
            return classifier;
        };
    }


}
