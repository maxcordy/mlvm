package be.unamur.bamand.openscad.ast;

public class Range implements Expression {

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

	private Expression start, increment, end;

	public Range(Expression start, Expression end) {
		this.start = start;
		this.end = end;
	}

	public Range(Expression start, Expression increment, Expression end) {
		this.start = start;
		this.increment = increment;
		this.end = end;
	}

	public Expression getStart() {
		return start;
	}

	public Expression getIncrement() {
		return increment;
	}

	public Expression getEnd() {
		return end;
	}
}
