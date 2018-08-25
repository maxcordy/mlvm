package be.unamur.mlvm.vm.constraints;

import be.unamur.mlvm.vm.*;

import java.util.List;
import java.util.stream.Collectors;

public class CardinalityConstraint implements Constraint {
    private final int minCardinality;
    private final int maxCardinality;
    private final List<FeatureId> features;

    public CardinalityConstraint(int minCardinality, int maxCardinality, List<FeatureId> features) {
        this.minCardinality = minCardinality;
        this.maxCardinality = maxCardinality;
        this.features = features;
    }

    @Override
    public boolean fulfil(Configuration configuration) {
        long count = features.stream()
                .map(configuration::valueOf)
                .filter(FeatureValues.TRUE::equals)
                .count();
        return (count >= minCardinality && count <= maxCardinality);
    }

    @Override
    public String toString() {
        return features.stream().map(Object::toString).collect(Collectors.joining(", ", "(", "){"+minCardinality+";"+maxCardinality+"}"));
    }
}
