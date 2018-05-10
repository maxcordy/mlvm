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

    public FeatureDomain getDomain(FeatureId id);
  
    public Set<ConstraintId> constraints();
    
    /**
     * @requires getName not null && 'this' has a constraint identified by 'getName'.
     * @return A new variability model obtained by removing from 'this' the
     * constraint identified by 'getName.
     */
    public VariabilityModel remove(ConstraintId id);

    public Constraint getConstraint(ConstraintId id);

    String getName();
}
