package be.unamur.mlvm.vm;

import be.unamur.mlvm.util.Assert;

/**
 * Immutable representation of a feature ID.
 * 
 * @author mcr
 */
public class FeatureId {

    public String getId() {
        return id;
    }

    private final String id;
    private int index;

    public FeatureId(String s) {
        Assert.notNull(s);
        Assert.notEmpty(s);

        this.id = s;
        this.index = -1;
    }

    FeatureId(String s, int index) {
        Assert.notNull(s);
        Assert.notEmpty(s);

        this.id = s;
        this.index = index;
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

    @Override
    public String toString() {
        return String.format("FeatureId[%s]", id);
    }

    int getIndex() {
        return index;
    }

    public void setIndex(int index) {
        this.index = index;
    }
}
