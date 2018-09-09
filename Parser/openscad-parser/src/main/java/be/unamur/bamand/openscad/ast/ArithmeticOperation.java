package be.unamur.bamand.openscad.ast;

public class ArithmeticOperation implements Expression {

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

	private Expression left, right;
	ArithmeticOperator operator;

	public ArithmeticOperation(ArithmeticOperator operator, Expression left, Expression right) {
		this.operator = operator;
		this.left = left;
		this.right = right;
	}

	public Expression getLeft() {
		return left;
	}

	public Expression getRight() {
		return right;
	}

	public ArithmeticOperator getOperator() {
		return operator;
	}
}
