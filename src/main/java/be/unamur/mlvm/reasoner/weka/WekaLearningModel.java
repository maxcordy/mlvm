package be.unamur.mlvm.reasoner.weka;

import be.unamur.mlvm.reasoner.LearningModel;
import be.unamur.mlvm.vm.*;
import weka.classifiers.Classifier;
import weka.core.Attribute;
import weka.core.DenseInstance;
import weka.core.Instance;
import weka.core.Instances;

import java.util.*;
import java.util.stream.Collectors;

public class WekaLearningModel implements LearningModel {
    private static final String VALID = "VALID";
    private static final String INVALID = "INVALID";

    private final Map<FeatureId, Attribute> features;
    private final ClassifierBuilder builder;
    private final Attribute validityAttribute;
    private final Instances trainingSet;
    private Classifier classifier;

    public WekaLearningModel(VariabilityModel model,
                             ClassifierBuilder builder,
                             int capacity) {
        this.builder = builder;
        features = new HashMap<>();
        ArrayList<Attribute> attributes = new ArrayList<>();
        validityAttribute = new Attribute("ConfigurationValidity", Arrays.asList(VALID, INVALID));
        attributes.add(validityAttribute);


        model.features().forEach(f -> {
            Attribute attribute = createAttribute(f, model.getDomain(f));
            features.put(f, attribute);
            attributes.add(attribute);
        });

        trainingSet = new Instances("trainingData", attributes, capacity);
        trainingSet.setClass(validityAttribute);

        try {
            builder.initialize(trainingSet);
        } catch(Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void train(Configuration c, boolean isValid) {
        if (this.isClassified())
            this.clearClassifier();

        Instance instance = buildInstance(c);
        instance.setValue(validityAttribute, isValid ? VALID : INVALID);
        try {
            builder.train(instance);
        } catch(Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void buildClassifier() {
        try {
            if (!this.isClassified())
                this.classifier = this.builder.build();

        } catch (Exception e) {
            throw new RuntimeException("Classification failed", e);
        }
    }

    @Override
    public boolean isValid(Configuration c) {
        this.buildClassifier();
        try {

            Instance instance = this.buildInstance(c);
            instance.setDataset(trainingSet);
            int index = (int) classifier.classifyInstance(instance);
            String validity = validityAttribute.value(index);
            return validity.equals(VALID);

        } catch (Exception e) {
            throw new RuntimeException("Classification failed", e);
        }
    }

    private boolean isClassified() {
        return this.classifier != null;
    }

    private Instance buildInstance(Configuration c) {
        Instance instance = new DenseInstance(features.size() + 1);
        features.forEach((feature, attribute) -> {
            FeatureValue val = c.valueOf(feature);
            addFeatureToInstance(instance, attribute, val);
        });
        return instance;
    }

    private void clearClassifier() {
        this.classifier = null;
    }


    private Attribute createAttribute(FeatureId id, FeatureDomain domain) {
        if (domain instanceof FeatureDomain.Nominal) {
            List<String> attributeValues = ((FeatureDomain.Nominal) domain).getValues()
                    .stream()
                    .map(FeatureValue::getValue)
                    .map(Object::toString)
                    .collect(Collectors.toList());
            return new Attribute(id.toString(), attributeValues);
        }
        if (domain instanceof FeatureDomain.Numeric) {
            return new Attribute(id.toString());
        }
        throw new RuntimeException("Unknown FeatureModel");
    }

    private void addFeatureToInstance(Instance instance, Attribute attribute, FeatureValue val) {
        Object value = val.getValue();
        if (attribute.isNumeric()) {
            instance.setValue(attribute, ((Number) value).doubleValue());
        } else {
            instance.setValue(attribute, value.toString());
        }
    }
}
