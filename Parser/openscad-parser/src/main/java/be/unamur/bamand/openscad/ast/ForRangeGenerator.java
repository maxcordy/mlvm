package be.unamur.bamand.openscad.ast;

import java.util.ArrayList;

public class ForRangeGenerator implements Generator {
    private ArrayList<Argument> args;
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

    public ForRangeGenerator(ArrayList<Argument> args, Generator child) {
        this.args = args;
        this.child = child;
    }

    public ArrayList<Argument> getArgs() {
        return args;
    }

    public Generator getChild() {
        return child;
    }
}
