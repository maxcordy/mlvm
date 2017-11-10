package be.unamur.mlvm.vm;

import be.unamur.mlvm.util.Assert;

/**
 * Immutable representation of a feature ID.
 * 
 * @author mcr
 */
public class FeatureId {
    
    
    private final String id;
    
    public FeatureId(String s) {
        Assert.notNull(s);
        Assert.notEmpty(s);
        
        this.id = s;
    }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        } else if (o == null) {
            return false;
        } else if (!(o instanceof FeatureId)) {
            return false;
        } else {
            FeatureId other = (FeatureId) o;
            return other.id.equals(this.id);
        }
    }

    @Override
    public int hashCode() {
        int result = 7;
        result = 13 * result + id.hashCode();

        return result;
    }
}
