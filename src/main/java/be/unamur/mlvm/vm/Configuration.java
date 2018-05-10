package be.unamur.mlvm.vm;

/**
 * Immutable representation of a configuration
 * 
 * @author mcr
 */
public interface Configuration {


    /**
     * @requires getName not null && 'this' has a feature identified by 'getName'
     * @return the value of feature 'getName' in 'this'
     */
    public FeatureValue valueOf(FeatureId id);

    public Configuration clone();
    
}
