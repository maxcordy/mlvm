package be.unamur.mlvm.vm.constraints;

import be.unamur.mlvm.vm.Configuration;
import be.unamur.mlvm.vm.Constraint;
import be.unamur.mlvm.vm.FeatureId;

import java.util.*;
import java.util.stream.Collectors;

public class Conjunction implements Constraint {
    private final List<Constraint> clauses;

    public Conjunction(Constraint... clauses) {
        this(Arrays.asList(clauses));
    }

    public Conjunction(List<Constraint> clauses) {
        this.clauses = clauses;
    }

    @Override
    public boolean fulfil(Configuration configuration) {
        return this.clauses.stream().allMatch(
                clause -> clause.fulfil(configuration));
    }

    @Override
    public String toString() {
        return clauses.stream().map(Object::toString).collect(Collectors.joining(" && ", "(", ")"));
    }
}
