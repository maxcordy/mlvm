package be.unamur.bamand.openscad.ast;

import edu.emory.mathcs.backport.java.util.Collections;

import java.util.List;

public class ModuleInstantiation implements Instruction {
    private String name;
    private List<Argument> args;
    private Instruction child;

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

    public ModuleInstantiation(String name, List<Argument> args) {
        this.name = name;
        this.args = args;
        if (args == null)
            this.args = Collections.emptyList();
    }

    public Instruction getChild() {
        return child;
    }

    public void setChild(Instruction child) {
        this.child = child;
    }

    public String getName() {
        return name;
    }

    public List<Argument> getArguments() {
        return args;
    }
}
