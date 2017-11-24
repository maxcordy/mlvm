package be.unamur.mlvm.reasoner.weka;

import be.unamur.mlvm.reasoner.LearningModel;
import be.unamur.mlvm.util.Assert;
import be.unamur.mlvm.vm.Configuration;
import be.unamur.mlvm.vm.FeatureId;
import be.unamur.mlvm.vm.FeatureValue;
import be.unamur.mlvm.vm.VariabilityModel;
import weka.classifiers.Classifier;
import weka.core.Attribute;
import weka.core.DenseInstance;
import weka.core.Instance;
import weka.core.Instances;

import java.util.*;

public class WekaLearningModel implements LearningModel {
    private static final String VALID = "VALID";
    private static final String INVALID = "INVALID";

    private final Map<FeatureId, Attribute> features;
    private final Instances trainingSet;
    private final ClassifierFactory factory;
    private final FeatureHandler featureHandler;
    private final Attribute validityAttribute;
    private Classifier classifier;

    public WekaLearningModel(VariabilityModel model,
                                ClassifierFactory factory,
                                FeatureHandler featureHandler,
                                int capacity) {
        Assert.notNull(model);
        Assert.notNull(factory);
        Assert.notNull(featureHandler);

        this.factory = factory;
        this.featureHandler = featureHandler;

        features = new HashMap<>();
        ArrayList<Attribute> attributes = new ArrayList<>();
        validityAttribute = new Attribute("ConfigurationValidity", Arrays.asList(VALID, INVALID));
        attributes.add(validityAttribute);


        model.features().forEach(f -> {
            Attribute attribute = featureHandler.createAttributeFor(f);
            features.put(f, attribute);
            attributes.add(attribute);
        });

        trainingSet = new Instances("trainingData", attributes, capacity);
        trainingSet.setClass(validityAttribute);
    }

    @Override
    public void train(Configuration c, boolean isValid) {
        if (this.isClassified())
            this.clearClassifier();

        Instance instance = buildInstance(c);
        instance.setValue(validityAttribute, isValid ? VALID : INVALID);
        trainingSet.add(instance);
    }

    @Override
    public boolean isValid(Configuration c) {
        try {
            if (!this.isClassified())
                this.buildClassifier();

            Instance instance = this.buildInstance(c);
            instance.setDataset(trainingSet);
            int index = (int) classifier.classifyInstance(instance);
            String validity = validityAttribute.value(index);
            return validity.equals(VALID);

        } catch (Exception e) {
            throw new RuntimeException("Classification failed", e);
        }
    }

    private void buildClassifier() throws Exception {
        this.classifier = this.factory.create(trainingSet);
    }

    private boolean isClassified() {
        return this.classifier != null;
    }

    private Instance buildInstance(Configuration c) {
        Instance instance = new DenseInstance(features.size() + 1);
        features.forEach((feature, attribute) -> {
            FeatureValue val = c.valueOf(feature);
            featureHandler.addFeatureToInstance(instance, attribute, val);
        });
        return instance;
    }

    private void clearClassifier() {
        this.classifier = null;
    }


}
