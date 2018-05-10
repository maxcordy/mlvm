package be.unamur.mlvm.vm.constraints;

import be.unamur.mlvm.vm.Configuration;
import be.unamur.mlvm.vm.Constraint;
import be.unamur.mlvm.vm.FeatureId;
import be.unamur.mlvm.vm.FeatureValues;

import java.util.*;

public abstract class TreeConstraint implements Constraint {
    private final FeatureId node;
    protected List<TreeConstraint> children = new ArrayList<>();

    public TreeConstraint(FeatureId node) {
        this.node = node;
    }

    @Override
    public boolean fulfil(Configuration configuration) {
        boolean present = isPresent(configuration);
        return this.children.stream().allMatch(x -> x.fulfil(configuration, present));
    }

    abstract boolean fulfil(Configuration configuration, boolean parentPresent);

    boolean isPresent(Configuration configuration) {
        return configuration.valueOf(node).equals(FeatureValues.TRUE);
    }

    boolean checkSubtree(Configuration configuration, boolean shouldBePresent) {
        return shouldBePresent == isPresent(configuration) &&
                this.children.stream().allMatch(x -> x.fulfil(configuration, shouldBePresent));
    }

    public void addChild(TreeConstraint child) {
        this.children.add(child);
    }

    public static class Mandatory extends TreeConstraint {

        public Mandatory(FeatureId node) {
            super(node);
        }

        @Override
        boolean fulfil(Configuration configuration, boolean parentPresent) {
            return (parentPresent == isPresent(configuration))
                    && checkSubtree(configuration, parentPresent);
        }
    }

    public static class Optional  extends TreeConstraint {

        public Optional(FeatureId node) {
            super(node);
        }

        @Override
        boolean fulfil(Configuration configuration, boolean parentPresent) {
            boolean childPresent = isPresent(configuration);
            return (parentPresent || !childPresent)
                    && checkSubtree(configuration, childPresent);
        }
    }

    public static class Group  extends TreeConstraint {
        private int minCardinality;
        private int maxCardinality;

        public Group(FeatureId id, int minCardinality, int maxCardinality) {
            super(id);
            this.minCardinality = minCardinality;
            this.maxCardinality = maxCardinality;
        }

        @Override
        public boolean fulfil(Configuration configuration, boolean parentPresent) {
            if (parentPresent) {
                int count = 0;
                for (TreeConstraint child : children) {
                    boolean present = child.isPresent(configuration);
                    if (present) count++;
                    if (!child.checkSubtree(configuration, present))
                        return false;
                }
                return count >= minCardinality && count <= maxCardinality;
            } else
                return children.stream().allMatch(x -> x.checkSubtree(configuration, false));
        }
    }
}
