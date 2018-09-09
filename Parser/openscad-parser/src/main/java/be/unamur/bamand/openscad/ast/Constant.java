package be.unamur.bamand.openscad.ast;

public class Constant implements Expression {
	private final Object value;
	private final LiteralType type;

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

	public Constant(boolean value) {
		this.value = value;
		this.type = LiteralType.BOOL;
	}

	public Constant(String value) {
		this.value = value;
		this.type = LiteralType.STRING;
	}

	public Constant(float value) {
		this.value = value;
		this.type = LiteralType.FLOAT;
	}

	public Constant() {
		this.value = null;
		this.type = LiteralType.UNDEF;
	}

	public Object getValue() {
		return value;
	}

	public LiteralType getType() {
		return type;
	}
}
