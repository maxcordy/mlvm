//package be.unamur.mlvm.vm;
//
//import java.util.*;
//import java.util.stream.Stream;
//
//public class DefaultVariabilityModel implements VariabilityModel {
//
//    private Map<ConstraintId, Constraint> constraints;
//    private Map<FeatureId, FeatureDomain> features;
//    private String name;
//
//    public DefaultVariabilityModel(String name) {
//        this.name = name;
//        this.features = new LinkedHashMap<>();
//        this.constraints = new HashMap<>();
//    }
//
//    private DefaultVariabilityModel(String name, Map<FeatureId, FeatureDomain> features, Map<ConstraintId, Constraint> constraints) {
//        this.name = name;
//        this.features = features;
//        this.constraints = constraints;
//    }
//
//    public void addFeature(FeatureId id, FeatureDomain domain) {
//        this.features.put(id, domain);
//    }
//
//    public void addConstraint(ConstraintId id, Constraint constraint) {
//        this.constraints.put(id, constraint);
//    }
//
//    @Override
//    public boolean isValid(Configuration c) {
//        return constraints.values().stream().allMatch(x -> x.fulfil(c));
//    }
//
//    public Stream<Constraint> failures(Configuration c) {
//        return constraints.values().stream().filter(x -> !x.fulfil(c));
//    }
//
//    @Override
//    public Set<FeatureId> features() {
//        return features.keySet();
//    }
//
//    @Override
//    public FeatureDomain getDomain(FeatureId id) {
//        return features.get(id);
//    }
//
//    @Override
//    public Set<ConstraintId> constraints() {
//        return this.constraints.keySet();
//    }
//
//    @Override
//    public VariabilityModel remove(ConstraintId id) {
//        LinkedHashMap<ConstraintId, Constraint> constraints1 = new LinkedHashMap<>(constraints);
//        constraints1.remove(id);
//        return new DefaultVariabilityModel(this.name, features, constraints1);
//    }
//
//    @Override
//    public String getName() {
//        return this.name;
//    }
//
//    public Constraint getConstraint(ConstraintId x) {
//        return constraints.get(x);
//    }
//}
//
//
