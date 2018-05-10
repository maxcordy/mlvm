package be.unamur.mlvm.vm;

import java.util.*;
import java.util.stream.Stream;

public class IndexedVariabilityModel implements VariabilityModel {

    private Map<ConstraintId, Constraint> constraints;
    private Set<FeatureId> featureIds;
    private List<FeatureDomain> featureDomains;
    private String name;

    public IndexedVariabilityModel(String name) {
        this.name = name;
        this.featureIds = new LinkedHashSet<>();
        this.featureDomains = new ArrayList<>();
        this.constraints = new LinkedHashMap<>();
    }

    private IndexedVariabilityModel(String name, Set<FeatureId> featureIds, List<FeatureDomain> featureDomains, LinkedHashMap<ConstraintId, Constraint> constraints) {
        this.name = name;
        this.featureIds = featureIds;
        this.featureDomains = featureDomains;
        this.constraints = constraints;
    }

    public void addFeature(FeatureId featureId, FeatureDomain domain) {
        if(this.featureIds.add(featureId))
            featureId.setIndex(this.featureIds.size() - 1);
        this.featureDomains.add(domain);
    }

    public void addConstraint(ConstraintId id, Constraint constraint) {
        this.constraints.put(id, constraint);
    }

    @Override
    public boolean isValid(Configuration c) {
        return constraints.values().stream().allMatch(x -> x.fulfil(c));
    }

    public Stream<Constraint> failures(Configuration c) {
        return constraints.values().stream().filter(x -> !x.fulfil(c));
    }

    @Override
    public Set<FeatureId> features() {
        return featureIds;
    }

    @Override
    public FeatureDomain getDomain(FeatureId id) {
        return featureDomains.get(id.getIndex());
    }

    @Override
    public Set<ConstraintId> constraints() {
        return this.constraints.keySet();
    }

    @Override
    public VariabilityModel remove(ConstraintId id) {
        LinkedHashMap<ConstraintId, Constraint> constraints1 = new LinkedHashMap<>(constraints);
        constraints1.remove(id);
        return new IndexedVariabilityModel(this.name, featureIds, featureDomains, constraints1);
    }

    @Override
    public String getName() {
        return this.name;
    }

    public Constraint getConstraint(ConstraintId x) {
        return constraints.get(x);
    }
}


