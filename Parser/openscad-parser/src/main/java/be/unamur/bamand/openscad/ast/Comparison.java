package be.unamur.bamand.openscad.ast;

public class Comparison implements Expression {

    private Expression left, right;
	ComparisonOperator operator;

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

	public Comparison(ComparisonOperator operator, Expression left, Expression right) {
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

	public ComparisonOperator getOperator() {
		return operator;
	}
}
