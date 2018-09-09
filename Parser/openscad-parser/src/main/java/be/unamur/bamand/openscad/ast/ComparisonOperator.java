package be.unamur.bamand.openscad.ast;

/**
 * Created by Benoit Amand on 07-07-16.
 */
public enum ComparisonOperator {
    LESS_THAN("<"), GREATER_THAN(">"), LESS_OR_EQUAL("<="), GREATER_OR_EQUAL(">="), EQUAL("=="), DIFFERENT("!=");

    private String operator;

    ComparisonOperator(String operator) {
        this.operator = operator;
    }

    public String getSymbol() {
        return operator;
    }
}
