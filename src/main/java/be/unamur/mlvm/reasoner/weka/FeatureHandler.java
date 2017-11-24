package be.unamur.mlvm.reasoner.weka;

import be.unamur.mlvm.vm.FeatureId;
import be.unamur.mlvm.vm.FeatureValue;
import weka.core.Attribute;
import weka.core.Instance;

public interface FeatureHandler {

    void addFeatureToInstance(Instance instance, Attribute attribute, FeatureValue feature) ;
    Attribute createAttributeFor(FeatureId f) ;
}
