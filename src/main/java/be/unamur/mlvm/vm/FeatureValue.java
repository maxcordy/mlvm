package be.unamur.mlvm.vm;

import be.unamur.mlvm.util.Assert;

/**
 * Immutable representation of a feature value.
 * 
 * @author mcr
 */
public class FeatureValue {
   
    private final String value;
    
    private FeatureValue(String s) {
        Assert.notNull(s);
        Assert.notEmpty(s);
        
        this.value = s;
    }
    
    public static FeatureValue parse(String s) {
        Assert.notNull(s);
        Assert.notEmpty(s);
        
        return new FeatureValue(s);
    }
    
    public boolean asBool() {
        switch (value) {
            case "true":
                return true;
            case "false":
                return false;
            default:
                Assert.shouldNeverGetHere();
                return true; // only to please the compiler
        }
    }
    
    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        } else if (o == null) {
            return false;
        } else if (!(o instanceof FeatureValue)) {
            return false;
        } else {
            FeatureValue other = (FeatureValue) o;
            return other.value.equals(this.value);
        }
    }

    @Override
    public int hashCode() {
        int result = 7;
        result = 13 * result + value.hashCode();

        return result;
    }
    
    @Override
    public String toString() {
        return value;
    }
}
