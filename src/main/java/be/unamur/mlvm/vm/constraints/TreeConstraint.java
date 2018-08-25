package be.unamur.mlvm.vm.constraints;

import be.unamur.mlvm.vm.Configuration;
import be.unamur.mlvm.vm.Constraint;
import be.unamur.mlvm.vm.FeatureId;
import be.unamur.mlvm.vm.FeatureValues;

import java.util.ArrayList;
import java.util.List;

public abstract class TreeConstraint implements Constraint {
    final FeatureId node;
    List<TreeConstraint> children = new ArrayList<>();

    TreeConstraint(FeatureId node) {
        this.node = node;
    }

    @Override
    public abstract boolean fulfil(Configuration configuration);

    public abstract void diag(Configuration configuration);

    boolean isPresent(Configuration configuration) {
        return configuration.valueOf(node).equals(FeatureValues.TRUE);
    }


    boolean hasNoPresentDescendants(Configuration configuration) {
        return this.children.stream().allMatch(x -> !x.isPresent(configuration) && x.hasNoPresentDescendants(configuration));
    }

    boolean fulfillChildren(Configuration configuration) {
        return children.stream().allMatch(x -> x.fulfil(configuration));
    }


    void diagChildren(Configuration configuration) {
        children.forEach(x -> x.diag(configuration));
    }

    void diagNoPresentDescendants(Configuration configuration, FeatureId node) {
        children.forEach(x -> {
            if (x.isPresent(configuration)) {
                System.out.println("(D) " + x.node.getId() + " child of dead " + node.getId());
            }
            x.diagNoPresentDescendants(configuration, node);
        });
    }


    public void addChild(TreeConstraint child) {
        this.children.add(child);
    }

    public static class Mandatory extends TreeConstraint {

        public Mandatory(FeatureId node) {
            super(node);
        }

        @Override
        public boolean fulfil(Configuration configuration) {
            return isPresent(configuration) && fulfillChildren(configuration);
        }

        @Override
        public void diag(Configuration configuration) {
            if (!isPresent(configuration)) {
                System.out.println("(M) " + node.getId() + " not present");
            } else
                diagChildren(configuration);
        }
    }

    public static class Optional extends TreeConstraint {

        public Optional(FeatureId node) {
            super(node);
        }


        @Override
        public boolean fulfil(Configuration configuration) {
            return isPresent(configuration) ?
                    fulfillChildren(configuration) :
                    hasNoPresentDescendants(configuration);
        }

        @Override
        public void diag(Configuration configuration) {
            if (isPresent(configuration))
                diagChildren(configuration);
            else
                diagNoPresentDescendants(configuration, node);
        }
    }

    public static class Group extends TreeConstraint {
        private int minCardinality;
        private int maxCardinality;

        public Group(FeatureId id, int minCardinality, int maxCardinality) {
            super(id);
            this.minCardinality = minCardinality;
            this.maxCardinality = maxCardinality;
        }

        @Override
        public boolean fulfil(Configuration configuration) {
            if(!isPresent(configuration)) return false;

            int count = 0;
            for (TreeConstraint child : children) {
                if (child.isPresent(configuration)) {
                    count++;
                    if (!child.fulfil(configuration))
                        return false;
                } else if (!child.hasNoPresentDescendants(configuration))
                    return false;
            }
            return count >= minCardinality && count <= maxCardinality;

        }

        @Override
        public void diag(Configuration configuration) {
if(!isPresent(configuration)) {
    System.out.println("(G) : Group not present");
    return;
}

            int count = 0;
            for (TreeConstraint child : children) {
                if (child.isPresent(configuration)) {
                    count++;
                    child.diagChildren(configuration);
                } else
                    child.diagNoPresentDescendants(configuration, child.node);
            }
            if (!(count >= minCardinality && count <= maxCardinality))
                System.out.println("(G) : Invalid cardinality : " + count);
        }
    }
}
