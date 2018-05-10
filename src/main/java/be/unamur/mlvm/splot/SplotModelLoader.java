package be.unamur.mlvm.splot;

import be.unamur.mlvm.vm.*;
import be.unamur.mlvm.vm.constraints.*;
import constraints.PropositionalFormula;
import fm.*;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class SplotModelLoader {
    private SplotModelLoader() {
    }

    // private static final Predicate<Configuration> ALWAYS_TRUE = x -> true;
    private Map<String, FeatureId> ids = new HashMap<>();

    public static VariabilityModel parse(String filename) throws FeatureModelException {
        FeatureModel featureModel = new XMLFeatureModel(filename, XMLFeatureModel.USE_VARIABLE_NAME_AS_ID);
        featureModel.loadModel();
        return new SplotModelLoader().toVariabilityModel(featureModel);
    }


    public static VariabilityModel generate3cnf(String name, int features, int mandatoryOdds, int optionalOdds, int group1NOdds, int group11Odds, int minChildrenPerNode, int maxChildrenPerNode, int maxGroupCardinality, int balanceFactor) throws FeatureModelException {
        FeatureModel featureModel = new RandomFeatureModel(name, features, mandatoryOdds, optionalOdds, group1NOdds, group11Odds, minChildrenPerNode, maxChildrenPerNode, maxGroupCardinality, balanceFactor);
        featureModel.loadModel();
        return new SplotModelLoader().toVariabilityModel(featureModel);
    }

    private VariabilityModel toVariabilityModel(FeatureModel featureModel) {
        IndexedVariabilityModel vm = new IndexedVariabilityModel(featureModel.getName());
        TreeConstraint treeConstraint = traverseTree(featureModel.getRoot());
        this.ids.values().forEach(x -> vm.addFeature(x, FeatureDomains.BOOLEAN));
        vm.addConstraint(new ConstraintId("TreeConstraints"), treeConstraint);

        for (PropositionalFormula formula : featureModel.getConstraints())
            vm.addConstraint(new ConstraintId(formula.getName()), toConstraint(formula));

//        FeatureModelStatistics stats = new FeatureModelStatistics(featureModel);
//        stats.update();
//        stats.dump();

        return vm;
    }

    private TreeConstraint traverseTree(FeatureTreeNode node) {
        /*if (node instanceof RootNode) {
            for (int i = 0; i < node.getChildCount(); i++)
                traverseTree(vm, (FeatureTreeNode) node.getChildAt(i), null);
            return null;
        } else */
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

    public static void main(String args[]) throws FeatureModelException {
        SplotModelLoader x = new SplotModelLoader();
        x.parse("c:\\Users\\amand\\OneDrive\\Documents\\master\\memoire2\\splot\\samples\\arcade_game_pl_fm.xml");
    }
}

