package be.unamur.bamand.openscad.ast;

public class EachGenerator implements Generator {
	private Generator child;

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

	public EachGenerator(Generator child) {
		this.child = child;
	}

	public Generator getChild() {
		return child;
	}
}
