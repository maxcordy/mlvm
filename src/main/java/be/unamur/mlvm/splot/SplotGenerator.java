package be.unamur.mlvm.splot;

import be.unamur.mlvm.vm.*;
import be.unamur.mlvm.vm.constraints.Disjunction;
import be.unamur.mlvm.vm.constraints.Equality;

import be.unamur.mlvm.vm.constraints.TreeConstraint;
import splar.constraints.PropositionalFormula;
import splar.fm.FeatureGroup;
import splar.fm.FeatureModel;
import splar.fm.FeatureModelException;
import splar.fm.FeatureTreeNode;
import splar.fm.RootNode;
import splar.fm.SolitaireFeature;
import splar.fm.randomization.Random3CNFFeatureModel;

import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

public class SplotGenerator {
    private SplotGenerator() {
    }

    // private static final Predicate<Configuration> ALWAYS_TRUE = x -> true;
    private Map<String, FeatureId> ids = new HashMap<>();


    public static VariabilityModel generate(String name, int features, int mandatoryOdds, int optionalOdds, int group1NOdds, int group11Odds, int minChildrenPerNode, int maxChildrenPerNode, int maxGroupCardinality, int balanceFactor) throws FeatureModelException {
        FeatureModel featureModel = new Random3CNFFeatureModel(name, features, mandatoryOdds, optionalOdds, group1NOdds, group11Odds, minChildrenPerNode, maxChildrenPerNode, maxGroupCardinality, balanceFactor);
        featureModel.loadModel();
        return new SplotGenerator().toVariabilityModel(featureModel);
    }
    private VariabilityModel toVariabilityModel(FeatureModel featureModel) {
        IndexedVariabilityModel vm = new IndexedVariabilityModel(featureModel.getName());
        TreeConstraint treeConstraint = traverseTree(featureModel.getRoot());
        this.ids.values().forEach(x -> vm.addFeature(x, FeatureDomains.BOOLEAN));
        vm.addConstraint(new ConstraintId("TreeConstraints"), treeConstraint);

        for (PropositionalFormula formula : featureModel.getConstraints())
            vm.addConstraint(new ConstraintId(formula.getName()), toConstraint(formula));
        return vm;
    }

    private TreeConstraint traverseTree(FeatureTreeNode node) {
        TreeConstraint c;
        FeatureId id = getFeatureId(node.getID());

        if (node instanceof RootNode)
            c = new TreeConstraint.Mandatory(id);
        if (node instanceof FeatureGroup) {
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

    private FeatureId getFeatureId(String id) {
        return this.ids.computeIfAbsent(id, FeatureId::new);
    }

    private Constraint toConstraint(PropositionalFormula formula) {
        return new Disjunction(
                formula.getVariables().stream()
                        .map(booleanVariable -> new Equality(getFeatureId(booleanVariable.getID()), FeatureValues.getBoolean(booleanVariable.isPositive())))
                        .collect(Collectors.toList()));
    }
}

