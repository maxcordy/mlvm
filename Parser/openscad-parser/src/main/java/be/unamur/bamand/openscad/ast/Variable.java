package be.unamur.bamand.openscad.ast;

public class Variable implements Expression {

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

	private String name;

	public Variable(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}
}
