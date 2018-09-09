package be.unamur.bamand.openscad.ast;

public class UnaryOperation implements Expression {

	private Location startLocation;
	private Location endLocation;

	@Override
	public Location getStartLocation() {
		return startLocation;
	}

	@Override
	public Location getEndLocation() {
		return endLocation;
	}

	@Override
	public void setLocation(Location start, Location end) {
		startLocation = start;
		endLocation = end;
	}

	private Expression expr;
	private UnaryOperator operator;

	public UnaryOperation(UnaryOperator operator, Expression expr) {
		this.operator = operator;
		this.expr = expr;
	}

	public Expression getExpr() {
		return expr;
	}

	public UnaryOperator getOperator() {
		return operator;
	}
}
