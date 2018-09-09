package be.unamur.bamand.openscad.ast;

import java.util.ArrayList;

public class FunctionDefinition implements ASTNode {

	private String name;
	private ArrayList<Parameter> params;
	private Expression expr;

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

	public FunctionDefinition(String name, ArrayList<Parameter> params, Expression expr) {
		this.name = name;
		this.params = params;
		this.expr = expr;
	}

	public String getName() {
		return name;
	}

	public ArrayList<Parameter> getParameters() {
		return params;
	}

	public Expression getBody() {
		return expr;
	}
}
