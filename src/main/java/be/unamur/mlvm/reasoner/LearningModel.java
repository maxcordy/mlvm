package be.unamur.mlvm.reasoner;

import be.unamur.mlvm.vm.Configuration;

/**
 * Mutable representation of a VM learning model.
 * 
 * @specfield vm [0-1] : variabilityModel // the variability model that acts as a
 * support for 'this'
 * 
 * @author mcr
 */
public interface LearningModel extends Oracle {
    
    /**
     * @requires c not null
     * @modifies this
     * @effects Train this based on 'c' and its validity as defined by 'isValid'
     */
    public void train(Configuration c, boolean isValid);

    public void buildClassifier();
}
