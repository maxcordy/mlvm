package be.unamur.mlvm.reasoner.weka;


import weka.classifiers.Classifier;
import weka.classifiers.UpdateableClassifier;
import weka.classifiers.bayes.NaiveBayes;
import weka.classifiers.bayes.NaiveBayesUpdateable;
import weka.classifiers.functions.*;
import weka.classifiers.functions.supportVector.*;
import weka.classifiers.lazy.IBk;
import weka.classifiers.lazy.KStar;
import weka.classifiers.meta.RandomCommittee;
import weka.classifiers.trees.*;
import weka.classifiers.trees.j48.NBTreeClassifierTree;
import weka.core.Drawable;
import weka.core.Instance;
import weka.core.Instances;
import weka.core.SelectedTag;

import java.util.function.Supplier;

public class Classifiers {


    public static ClassifierFactory J48() {
        return createFactory("J48", J48::new);
    }

    public static ClassifierFactory NaiveBayes() {
        return createFactory("NaiveBayes", NaiveBayes::new);
    }

    public static ClassifierFactory RandomForest() {
        return createFactory("RandomForest", RandomForest::new);
    }

    public static ClassifierFactory StochasticGradientDescend() {
        return createUpdatableFactory("StochasticGradientDescend", () -> {
            SGD sgd = new SGD();
            sgd.setEpochs(500);
            sgd.setLossFunction(new SelectedTag(SGD.HINGE, SGD.TAGS_SELECTION));
            return sgd;
        });
    }

    public static ClassifierFactory IBk() {
        return createUpdatableFactory("IBk", IBk::new);
    }

    public static ClassifierFactory NaiveBayesUpdateable() {
        return createUpdatableFactory("NaiveBayesUpdateable", NaiveBayesUpdateable::new);
    }

    public static ClassifierFactory KStar() {
        return createUpdatableFactory("KStar", KStar::new);
    }

    public static ClassifierFactory LWL() {
        return createUpdatableFactory("LWL", KStar::new);
    }

    public static ClassifierFactory LogisticModelTree() {
        return createFactory("LogisticModelTree", LMT::new);
    }

    public static ClassifierFactory HoeffdingTree() {
        return createUpdatableFactory("HoeffdingTree", HoeffdingTree::new);
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

    private static ClassifierFactory createFactory(String label, Supplier<Classifier> supplier) {

        return new ClassifierFactory() {
            @Override
            public String getLabel() {
                return label;
            }

            @Override
            public ClassifierBuilder create() {
                return new ClassifierBuilderImpl(supplier);
            }
        };
    }

    private static <T extends UpdateableClassifier & Classifier> ClassifierFactory createUpdatableFactory(String label, Supplier<T> builder) {

        return new ClassifierFactory() {
            @Override
            public String getLabel() {
                return label;
            }

            @Override
            public ClassifierBuilder create() {
                return new UpdatableClassifierBuilderImpl(builder);
            }
        };
    }

    private static class ClassifierBuilderImpl implements ClassifierBuilder {

        private final Supplier<Classifier> supplier;
        private Instances instances;

        public ClassifierBuilderImpl(Supplier<Classifier> supplier) {

            this.supplier = supplier;
        }

        @Override
        public void initialize(Instances instances) {
            this.instances = instances;
        }

        @Override
        public void train(Instance instance) {
            this.instances.add(instance);
        }

        @Override
        public Classifier build() throws Exception {
            Classifier classifier = supplier.get();
            classifier.buildClassifier(instances);
//                System.out.println(trainingSet.toString());
//                if(classifier instanceof Drawable) {
//                    Drawable drawable = (Drawable) classifier;
//                    System.out.println("Built classifier: " + label);
//                    System.out.println("graph: " + drawable.graphType());
//                    System.out.println("graph: " + drawable.graph());
//                }
            return classifier;
        }
    }

    private static class UpdatableClassifierBuilderImpl implements ClassifierBuilder {

        private final Supplier<Classifier> supplier;
        private Classifier classifier;
        private UpdateableClassifier updatable;
        private Instances instances;

        public <T extends UpdateableClassifier & Classifier> UpdatableClassifierBuilderImpl(Supplier<T> supplier) {
            this.supplier = supplier::get;
        }

        @Override
        public void initialize(Instances instances) throws Exception {
            this.instances = instances;
            this.classifier = supplier.get();
            this.classifier.buildClassifier(instances);
            this.updatable = (UpdateableClassifier) classifier;
        }

        @Override
        public void train(Instance instance) throws Exception {
            instance.setDataset(instances);
            this.updatable.updateClassifier(instance);
        }

        @Override
        public Classifier build() throws Exception {
            return classifier;
        }
    }
}
