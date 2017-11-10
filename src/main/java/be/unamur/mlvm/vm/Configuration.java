package be.unamur.mlvm.vm;

/**
 * Immutable representation of a configuration
 * 
 * @author mcr
 */
public interface Configuration {
   
    
    /**
     * @requires id not null && 'this' has a feature identified by 'id'
     * @return the value of feature 'id' in 'this'
     */
    public FeatureValue valueOf(FeatureId id);
    
}
