package be.unamur.bamand.openscad.ast;

import java.util.ArrayList;

public class ForGenerator implements Generator {
	private ArrayList<Argument> init, incr;
	private Expression condition;
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

	public ForGenerator(ArrayList<Argument> init, Expression condition,
			ArrayList<Argument> incr, Generator child) {
		this.init = init;
		this.condition = condition;
		this.incr = incr;
		this.child = child;
	}

	public ArrayList<Argument> getInit() {
		return init;
	}

	public ArrayList<Argument> getIncr() {
		return incr;
	}

	public Expression getCondition() {
		return condition;
	}

	public Generator getChild() {
		return child;
	}
}
