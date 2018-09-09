package be.unamur.bamand.openscad.ast;

/**
 * Created by Benoit Amand on 07-07-16.
 */
public enum ArithmeticOperator {
    ADD("+"), SUB("-"), MUL("*"), DIV("/"), MOD("%");

    private String symbol;

    ArithmeticOperator(String symbol) {

        this.symbol = symbol;
    }

    public String getSymbol() {
        return symbol;
    }
}
