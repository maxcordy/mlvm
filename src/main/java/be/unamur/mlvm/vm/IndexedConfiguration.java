package be.unamur.mlvm.vm;

import java.util.Arrays;
import java.util.Map;

public class IndexedConfiguration implements Configuration {
    private final FeatureValue[] values;

    public IndexedConfiguration(FeatureValue[] values) {
        this.values = values;
    }

    public IndexedConfiguration(VariabilityModel model, Map<FeatureId, FeatureValue> values) {
        this.values = new FeatureValue[model.features().size()];
        model.features().forEach(k -> this.values[k.getIndex()] = values.get(k));
    }

    @Override
    public FeatureValue valueOf(FeatureId id) {
        return values[id.getIndex()];
    }

    @Override
    public Configuration clone() {
        return new IndexedConfiguration(Arrays.copyOf(values, values.length));
    }

    public void setValue(FeatureId feature, FeatureValue value) {
        this.values[feature.getIndex()] = value;
    }
}
