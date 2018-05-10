package be.unamur.mlvm.vm.constraints;

import be.unamur.mlvm.vm.Configuration;
import be.unamur.mlvm.vm.Constraint;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class CardinalityConstraint implements Constraint {
    private final int minCardinality;
    private final int maxCardinality;
    private final List<Constraint> constraints;

    public CardinalityConstraint(int minCardinality, int maxCardinality, Constraint ... constraints) {
        this(minCardinality, maxCardinality, Arrays.asList(constraints));
    }

    public CardinalityConstraint(int minCardinality, int maxCardinality, List<Constraint>constraints) {

        this.minCardinality = minCardinality;
        this.maxCardinality = maxCardinality;
        this.constraints = constraints;
    }

    @Override
    public boolean fulfil(Configuration configuration) {
        long count = constraints.stream()
                .filter(constraint -> constraint.fulfil(configuration))
                .count();
        return (count >= minCardinality && count <= maxCardinality);
    }

    @Override
    public String toString() {
        return constraints.stream().map(Object::toString).collect(Collectors.joining(", ", "(", "){"+minCardinality+";"+maxCardinality+"}"));
    }
}
