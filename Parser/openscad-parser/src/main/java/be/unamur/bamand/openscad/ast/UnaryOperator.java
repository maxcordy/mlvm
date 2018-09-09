package be.unamur.bamand.openscad.ast;

/**
 * Created by Benoit Amand on 07-07-16.
 */
public enum UnaryOperator {
    PLUS("+"), MINUS("-"), NOT("!");

	private String symbol;

	UnaryOperator(String symbol) {
		this.symbol = symbol;
	}

	public String getSymbol() {
		return symbol;
	}
}
