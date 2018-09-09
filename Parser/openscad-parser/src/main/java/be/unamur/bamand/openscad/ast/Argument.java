package be.unamur.bamand.openscad.ast;

public class Argument implements ASTNode {
	private String name;
	private Expression value;

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

	public Argument(Expression value) {
		this.value = value;
	}

	public Argument(String name, Expression value) {
		this.name = name;
		this.value = value;
	}

	public String getName() {
		return name;
	}

	public Expression getValue() {
		return value;
	}
}
