package be.unamur.mlvm.test;

import be.unamur.mlvm.vm.*;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.function.Predicate;

public class MockVariabilityModel implements VariabilityModel {

    private Map<ConstraintId, Predicate<Configuration>> constraints;
    private Set<FeatureId> features;

    MockVariabilityModel(Set<FeatureId> features, Map<ConstraintId, Predicate<Configuration>> constraints) {
        this.features = features;
        this.constraints = constraints;
    }

    @Override
    public boolean isValid(Configuration c) {
        return constraints.values().stream().allMatch(x -> x.test(c));
    }

    @Override
    public Set<FeatureId> features() {
        return features;
    }

    @Override
    public Set<ConstraintId> constraints() {
        return this.constraints.keySet();
    }

    @Override
    public VariabilityModel remove(ConstraintId id) {
        HashMap<ConstraintId, Predicate<Configuration>> constraints1 = new HashMap<>(constraints);
        constraints1.remove(id);
        return new MockVariabilityModel(features, constraints1);
    }
}


class MockConfiguration implements Configuration {
    private final Map<FeatureId, FeatureValue> values;

    MockConfiguration(Map<FeatureId, FeatureValue> values) {
        this.values = values;
    }

    @Override
    public FeatureValue valueOf(FeatureId id) {
        return values.get(id);
    }
}