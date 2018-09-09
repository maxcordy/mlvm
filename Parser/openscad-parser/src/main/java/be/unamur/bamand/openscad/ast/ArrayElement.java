package be.unamur.bamand.openscad.ast;

public class ArrayElement implements Expression {

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

	private Expression array, element;

	public ArrayElement(Expression array, Expression element) {
		this.array = array;
		this.element = element;
	}

	public Expression getArray() {
		return array;
	}

	public Expression getElement() {
		return element;
	}
}
