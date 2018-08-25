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
        if (fa != null && fb != null)
            return configuration.valueOf(fa).equals(configuration.valueOf(fb));
        else if (fa != null)
            return configuration.valueOf(fa).equals(c);
        else
        return configuration.valueOf(fb).equals(c);


//        return Optional.ofNullable(fa).map(configuration::valueOf).orElse(c)
//                .equals(Optional.ofNullable(fb).map(configuration::valueOf).orElse(c));
    }

    @Override
    public String toString() {
        return getEither(fa, c) + " == " + getEither(fb, c);
    }

    private String getEither(FeatureId f, FeatureValue c) {
        if (f != null) return f.getId();
        return c.toString();
    }
}
