package be.unamur.mlvm.vm;

import be.unamur.mlvm.reasoner.Oracle;
import java.util.Set;

/**
 * Immutable representation of a variability model.
 * 
 * @author mcr
 */
public interface VariabilityModel extends Oracle {
    
    public Set<FeatureId> features();
  
    public Set<ConstraintId> constraints();
    
    /**
     * @requires id not null && 'this' has a constraint identified by 'id'.
     * @return A new variability model obtained by removing from 'this' the
     * constraint identified by 'id. 
     */
    public VariabilityModel remove(ConstraintId id);
}
