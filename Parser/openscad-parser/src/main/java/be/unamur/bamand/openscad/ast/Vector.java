package be.unamur.bamand.openscad.ast;

import java.util.ArrayList;

public class Vector implements Expression {

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

	private final ArrayList<Expression> elements;

	public Vector(ArrayList<Expression> elements) {
		this.elements = elements;
	}

	public ArrayList<Expression> getElements() {
		return elements;
	}
}
