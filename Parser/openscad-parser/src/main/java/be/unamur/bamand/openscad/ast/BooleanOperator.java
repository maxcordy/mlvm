package be.unamur.bamand.openscad.ast;

/**
 * Created by Benoit Amand on 07-07-16.
 */
public enum BooleanOperator {
    AND("&&"), OR("||");

    private String symbol;

    BooleanOperator(String symbol) {

        this.symbol = symbol;
    }

    public String getSymbol() {
        return symbol;
    }
}
