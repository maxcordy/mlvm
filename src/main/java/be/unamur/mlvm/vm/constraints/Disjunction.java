package be.unamur.mlvm.vm.constraints;

import be.unamur.mlvm.vm.Configuration;
import be.unamur.mlvm.vm.Constraint;
import be.unamur.mlvm.vm.FeatureId;

import java.util.*;
import java.util.stream.Collectors;

public class Disjunction implements Constraint {
    private final List<Constraint> clauses;

    public Disjunction(Constraint... clauses) {
        this(Arrays.asList(clauses));
    }

    public Disjunction(List<Constraint> clauses) {
        this.clauses = clauses;
    }

    @Override
    public boolean fulfil(Configuration configuration) {
        return clauses.stream()
                .anyMatch(literal -> literal.fulfil(configuration));
    }

    public String toString() {
        return clauses.stream().map(Object::toString).collect(Collectors.joining(" || ", "(", ")"));
    }
}
