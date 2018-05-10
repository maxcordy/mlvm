package be.unamur.mlvm.vm;

public class FeatureValues {
    public static FeatureValue TRUE = FeatureValue.parse("true");
    public static FeatureValue FALSE = FeatureValue.parse("false");

    public static FeatureValue getBoolean(boolean v) {
        return v ? TRUE : FALSE;
    }
}

