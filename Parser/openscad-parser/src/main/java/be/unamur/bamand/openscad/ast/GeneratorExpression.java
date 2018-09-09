package be.unamur.bamand.openscad.ast;

import java.util.ArrayList;

public class GeneratorExpression implements Expression {

	private final Generator generator;
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

	public GeneratorExpression(Generator generator) {
		this.generator = generator;
	}

	public Generator getGenerator() {
		return generator;
	}
}
