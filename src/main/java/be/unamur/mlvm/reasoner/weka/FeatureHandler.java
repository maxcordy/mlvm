package be.unamur.mlvm.reasoner.weka;

import be.unamur.mlvm.vm.FeatureId;
import be.unamur.mlvm.vm.FeatureValue;
import weka.core.Attribute;
import weka.core.Instance;

/**
 * This class handle the conversion between the VM feature and Weka attributes
 */
public interface FeatureHandler {

    /**
     * Converts the given feature value and adds it to the given instance
     *
     * @param instance  a weka instance
     * @param attribute the corresponding weka attribute to the vm feature
     * @param feature   the feature value for the current configuration
     */
    void addFeatureToInstance(Instance instance, Attribute attribute, FeatureValue feature);

    /**
     * @param f a vm feature
     * @return a Weko attribute for the feature
     */
    Attribute createAttributeFor(FeatureId f);
}
