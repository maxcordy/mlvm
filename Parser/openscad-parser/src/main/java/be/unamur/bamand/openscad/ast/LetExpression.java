package be.unamur.bamand.openscad.ast;

import java.util.ArrayList;

public class LetExpression implements Expression {
    private ArrayList<Argument> args;
    private Expression child;

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

    public LetExpression(ArrayList<Argument> args, Expression child) {
        this.args = args;
        this.child = child;
    }

    public ArrayList<Argument> getArgs() {
        return args;
    }

    public Expression getChild() {
        return child;
    }
}
