package be.unamur.mlvm.vm;

import be.unamur.mlvm.util.Assert;

/**
 * Immutable representation of a constraint ID.
 * 
 * @author mcr
 */
public class ConstraintId {

    private final String id;
    
    public ConstraintId(String s) {
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
        } else if (!(o instanceof ConstraintId)) {
            return false;
        } else {
            ConstraintId other = (ConstraintId) o;
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
