package be.unamur.bamand.openscad.ast;

import be.unamur.bamand.openscad.Annotatable;
import be.unamur.bamand.openscad.AstPrinter;

public class VariableDefinition implements ASTNode {

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

	public VariableDefinition(String name, Expression value) {
		this.name = name;
		this.value = value;
	}

	public String getName() {
		return name;
	}

	public Expression getValue() {
		return value;
	}

	@Override
	public String toString() {
		return name + '=' + new AstPrinter().toString(value);
	}
}
