package be.unamur.bamand.openscad.ast;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class FunctionCall implements Expression {

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
	private List<Argument> arguments;

	public FunctionCall(String name, ArrayList<Argument> arguments) {
		this.name = name;
		this.arguments = (arguments == null ? Collections.emptyList() : arguments);
	}

	public String getName() {
		return name;
	}

	public List<Argument> getArguments() {
		return arguments;
	}
}
