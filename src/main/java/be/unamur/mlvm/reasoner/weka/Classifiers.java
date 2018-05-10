package be.unamur.mlvm.reasoner.weka;


import weka.classifiers.Classifier;
import weka.classifiers.bayes.NaiveBayes;
import weka.classifiers.functions.*;
import weka.classifiers.functions.supportVector.*;
import weka.classifiers.meta.RandomCommittee;
import weka.classifiers.trees.*;
import weka.classifiers.trees.j48.NBTreeClassifierTree;
import weka.core.Instances;

import java.util.function.Supplier;

public class Classifiers {


    public static ClassifierFactory J48() {
        return createFactory("J48", J48::new);
    }

    public static ClassifierFactory NaiveBayes() {
        return createFactory("NaiveBayes", NaiveBayes::new);
    }

    public static ClassifierFactory StochasticGradientDescend() {
        return createFactory("StochasticGradientDescend", SGD::new);
    }

    public static ClassifierFactory RandomForest() {
        return createFactory("RandomForest", RandomForest::new);
    }

    public static ClassifierFactory LogisticModelTree() {
        return createFactory("LogisticModelTree", LMT::new);
    }

    public static ClassifierFactory HoeffdingTree() {
        return createFactory("HoeffdingTree", HoeffdingTree::new);
    }

    public static ClassifierFactory RandomCommittee() {
        return createFactory("RandomCommittee", RandomCommittee::new);
    }

    public static ClassifierFactory REPTree() {
        return createFactory("REPTree", REPTree::new);
    }

    public static ClassifierFactory MultilayerPerceptron() {
        return createFactory("MultilayerPerceptron", MultilayerPerceptron::new);
    }

    public static ClassifierFactory LogisticRegression() {
        return createFactory("Logistic", Logistic::new);
    }

    public static ClassifierFactory SVM_Linear() {
        return createFactory("SVM_Linear", LibSVM("-K 0"));
    }

    public static ClassifierFactory SVM_Sigmoid(double gamma) {
        return createFactory("SVM_Sigmoid[" + gamma + "]", LibSVM("-K 3 -G " + gamma));
    }

    public static ClassifierFactory SVM_Sigmoid(double gamma, double coef0) {
        return createFactory("SVM_Sigmoid[" + gamma + "," + coef0 + "]", LibSVM("-K 3 -G " + gamma + " -R " + coef0));
    }

    public static ClassifierFactory SVM_Puk(double omega, double sigma) {
        Puk puk = new Puk();
        puk.setOmega(omega);
        puk.setSigma(sigma);
        return createFactory("SVM_Puk[" + omega + ", " + sigma + "]", createSVM(puk));
    }

    public static ClassifierFactory SVM_RBF(double gamma) {
        return createFactory("SVM_RBF[" + gamma + "]", LibSVM("-K 2 -G " + gamma));
    }

    public static ClassifierFactory SVM_Poly(int degree) {
        return createFactory("SVM_Poly[" + degree + "]", LibSVM("-K 1 -D " + degree));
    }

    public static ClassifierFactory SVM_Poly(int degree, double gamma, double coef0) {
        return createFactory("SVM_Poly[" + degree + "," + gamma + "," + coef0 + "]", LibSVM("-K 1 -D " + degree + " -G " + gamma + " -R " + coef0));
    }

    private static Supplier<Classifier> createSVM(Kernel kernel) {
        return () -> {
            SMO smo = new SMO();

            smo.setKernel(kernel);
            return smo;
        };
    }

    private static Supplier<Classifier> LibSVM(String options) {
        LibSVM svm = new LibSVM();
        try {
            svm.setOptions(options.split(" "));
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return () -> svm;
    }


    private static ClassifierFactory createFactory(String label, Supplier<Classifier> builder) {
        return new ClassifierFactory() {
            @Override
            public String getLabel() {
                return label;
            }

            @Override
            public Classifier create(Instances trainingSet) throws Exception {
                Classifier classifier = builder.get();
                classifier.buildClassifier(trainingSet);
                return classifier;
            }
        };
    }
}
