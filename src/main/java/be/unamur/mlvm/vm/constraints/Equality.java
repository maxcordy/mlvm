package be.unamur.mlvm.vm.constraints;

import be.unamur.mlvm.vm.Configuration;
import be.unamur.mlvm.vm.Constraint;
import be.unamur.mlvm.vm.FeatureId;
import be.unamur.mlvm.vm.FeatureValue;

import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

public class Equality implements Constraint {

    private final FeatureId fa;
    private final FeatureId fb;
    private final FeatureValue c;

    public Equality(FeatureId a, FeatureId b) {
        fa = a;
        fb = b;
        c = null;
    }

    public Equality(FeatureId a, FeatureValue b) {
        fa = a;
        fb = null;
        c = b;
    }

    public Equality(FeatureValue a, FeatureId b) {
        fa = null;
        fb = b;
        c = a;
    }

    @Override
    public boolean fulfil(Configuration configuration) {
        return Optional.ofNullable(fa).map(configuration::valueOf).orElse(c)
                .equals(Optional.ofNullable(fb).map(configuration::valueOf).orElse(c));
    }

    @Override
    public String toString() {
        return Optional.<Object>ofNullable(fa).orElse(c) + " == " + Optional.<Object>ofNullable(fb).orElse(c);
    }
}
