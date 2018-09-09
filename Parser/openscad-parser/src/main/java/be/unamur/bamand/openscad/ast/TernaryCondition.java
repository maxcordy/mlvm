package be.unamur.bamand.openscad.ast;


public class TernaryCondition implements Expression {
	private Expression condition;
	private Expression truthy;
	private Expression falsey;

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

	public TernaryCondition(Expression cond, Expression truthy, Expression falsey) {
		this.condition = cond;
		this.truthy = truthy;
		this.falsey = falsey;
	}

	public Expression getCondition() {
		return condition;
	}

	public Expression getTruthyValue() {
		return truthy;
	}

	public Expression getFalseyValue() {
		return falsey;
	}
}
