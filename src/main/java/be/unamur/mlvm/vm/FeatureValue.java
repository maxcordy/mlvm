package be.unamur.mlvm.vm;

import be.unamur.mlvm.util.Assert;

/**
 * Immutable representation of a feature value.
 *
 * @author mcr
 */
public class FeatureValue implements Comparable<FeatureValue> {

    private final Object value;

    public FeatureValue(String s) {
        Assert.notNull(s);
        this.value = s;
    }

    public FeatureValue(double s) {
        this.value = s;
    }

    public static FeatureValue parse(String s) {
        Assert.notNull(s);
        Assert.notEmpty(s);

        return new FeatureValue(s);
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
        return value.toString();
    }

    public Object getValue() {
        return value;
    }

    public int compareTo(FeatureValue featureValue) {
        if (value instanceof Number && featureValue.value instanceof Number)
            return Double.compare(((Number) value).doubleValue(), ((Number) featureValue.value).doubleValue());
        return value.toString().compareTo(featureValue.value.toString());
    }
}
