package be.unamur.mlvm.reasoner.weka;

import be.unamur.mlvm.vm.FeatureId;
import be.unamur.mlvm.vm.FeatureValue;
import weka.core.Attribute;
import weka.core.Instance;

import java.util.Arrays;
import java.util.List;

public class BooleanFeatureHandler implements FeatureHandler {

    private static final List<String> BOOLEAN_ATTRIBUTE_VALUES = Arrays.asList("true", "false");

    public void addFeatureToInstance(Instance instance, Attribute attribute, FeatureValue feature) {
        instance.setValue(attribute, feature.asBool() ? "true" : "false");
    }

    public  Attribute createAttributeFor(FeatureId f) {
        return new Attribute(f.toString(), BOOLEAN_ATTRIBUTE_VALUES);
    }
}
