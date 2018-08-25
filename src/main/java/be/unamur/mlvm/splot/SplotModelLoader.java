package be.unamur.mlvm.splot;

import be.unamur.mlvm.vm.*;
import be.unamur.mlvm.vm.constraints.*;
import constraints.BooleanVariable;
import constraints.PropositionalFormula;
import fm.*;
import org.sat4j.minisat.core.Constr;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class SplotModelLoader {
    private Map<String, FeatureId> ids = new HashMap<>();
    private final IndexedVariabilityModel vm;

    private SplotModelLoader(String name) {
        vm = new IndexedVariabilityModel(name);
    }

    public static VariabilityModel parse(String filename) throws FeatureModelException {
        FeatureModel featureModel = new XMLFeatureModel(filename, XMLFeatureModel.USE_VARIABLE_NAME_AS_ID);
        featureModel.loadModel();
        SplotModelLoader loader = new SplotModelLoader(featureModel.getName());
        loader.parseTree(featureModel.getRoot());
        loader.parseConstraints(featureModel.getConstraints());
        return loader.vm;
    }

    public static VariabilityModel parseWithSplitConstraints(String filename) throws FeatureModelException {
        FeatureModel featureModel = new XMLFeatureModel(filename, XMLFeatureModel.USE_VARIABLE_NAME_AS_ID);
        featureModel.loadModel();
        SplotModelLoader loader = new SplotModelLoader(featureModel.getName());
        loader.parseTreeSplit(featureModel.getRoot(), null);
        loader.parseConstraints(featureModel.getConstraints());
        return loader.vm;
    }


//    public static VariabilityModel generate3cnf(String name, int features, int mandatoryOdds, int optionalOdds, int group1NOdds, int group11Odds, int minChildrenPerNode, int maxChildrenPerNode, int maxGroupCardinality, int balanceFactor) throws FeatureModelException {
//        FeatureModel featureModel = new RandomFeatureModel(name, features, mandatoryOdds, optionalOdds, group1NOdds, group11Odds, minChildrenPerNode, maxChildrenPerNode, maxGroupCardinality, balanceFactor);
//        featureModel.loadModel();
//        return new SplotModelLoader().toVariabilityModel(featureModel);
//    }


    private void parseTree(FeatureTreeNode root) {
        TreeConstraint treeConstraint = traverseTree(root);
        vm.addConstraint(new ConstraintId("TreeConstraints"), treeConstraint);
    }

    private void parseConstraints(Collection<PropositionalFormula> constraints) {
        for (PropositionalFormula formula : constraints)
            vm.addConstraint(new ConstraintId(formula.getName()), toConstraint(formula));
    }

    private TreeConstraint traverseTree(FeatureTreeNode node) {
        TreeConstraint c;
        FeatureId id = getFeatureId(node);

        if (node instanceof RootNode)
            c = new TreeConstraint.Mandatory(id);
        else if (node instanceof FeatureGroup) {
            int min = ((FeatureGroup) node).getMin();
            int max = ((FeatureGroup) node).getMax() == -1 ? node.getChildCount() : ((FeatureGroup) node).getMax();
            c = new TreeConstraint.Group(id, min, max);
        } else {
            boolean mandatory = node instanceof SolitaireFeature && !((SolitaireFeature) node).isOptional();
            if (mandatory)
                c = new TreeConstraint.Mandatory(id);
            else
                c = new TreeConstraint.Optional(id);
        }
        for (int i = 0; i < node.getChildCount(); i++)
            c.addChild(traverseTree((FeatureTreeNode) node.getChildAt(i)));
        return c;
    }


    private void parseTreeSplit(FeatureTreeNode node, FeatureId parent) {

        FeatureId id = getFeatureId(node);
        List<Constraint> cs = new ArrayList<>();

        for (int i = 0; i < node.getChildCount(); i++) {
            List<Constraint> cs1 = new ArrayList<>();
            FeatureTreeNode cNode = (FeatureTreeNode) node.getChildAt(i);
            FeatureId cId = getFeatureId(cNode);
            parseTreeSplit(cNode, id);
            if (!cId.equals(parent))
                cs1.add(new Equality(cId, FeatureValues.FALSE));

            if (cs1.size() > 0)
                cs.add(new Disjunction(new Equality(id, FeatureValues.TRUE), new Conjunction(cs1)));
        }

        if (node instanceof RootNode) {
            cs.clear();
            cs.add(new Equality(id, FeatureValues.TRUE));

        } else if (node instanceof FeatureGroup) {
            int min = ((FeatureGroup) node).getMin();
            int max = ((FeatureGroup) node).getMax() == -1 ? node.getChildCount() : ((FeatureGroup) node).getMax();

            List<FeatureId> children = new ArrayList<>();
            for (int i = 0; i < node.getChildCount(); i++)
                children.add(getFeatureId((FeatureTreeNode) node.getChildAt(i)));

            cs.add(new Disjunction(new Equality(parent, FeatureValues.FALSE), new CardinalityConstraint(min, max, children)));

        } else if (node instanceof SolitaireFeature && !((SolitaireFeature) node).isOptional())
            cs.add(new Equality(parent, id));

        if (!cs.isEmpty())
            vm.addConstraint(new ConstraintId("tree_" + node.getID()), cs.size() == 1 ? cs.get(0) : new Conjunction(cs));
    }

    private FeatureId getFeatureId(FeatureTreeNode node) {
        if (node instanceof FeatureGroup)
            return getFeatureId((FeatureTreeNode) node.getParent());

        return this.ids.computeIfAbsent(node.getID(), s -> {
            FeatureId featureId = new FeatureId(s);
            this.vm.addFeature(featureId, FeatureDomains.BOOLEAN);
            return featureId;
        });
    }


    private FeatureId getFeatureId(BooleanVariable var) {
        FeatureId featureId = this.ids.get(var.getID());
        if (featureId == null)
            throw new RuntimeException("Invalid variable " + var);
        return featureId;
    }

    private Constraint toConstraint(PropositionalFormula formula) {
        return new Disjunction(
                formula.getVariables().stream()
                        .map(booleanVariable -> new Equality(getFeatureId(booleanVariable), FeatureValues.getBoolean(booleanVariable.isPositive())))
                        .collect(Collectors.toList()));
    }
}

