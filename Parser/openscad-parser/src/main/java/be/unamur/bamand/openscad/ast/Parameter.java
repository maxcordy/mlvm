package be.unamur.bamand.openscad.ast;

public class Parameter implements ASTNode {
    private String name;
    private Expression defaultValue;

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

    public Parameter(String name) {
        this.name = name;
    }

    public Parameter(String name, Expression defaultValue) {
        this.name = name;
        this.setDefaultValue(defaultValue);
    }

    public Expression getDefaultValue() {
        return defaultValue;
    }

    public void setDefaultValue(Expression defaultValue) {
        this.defaultValue = defaultValue;
    }

    public String getName() {
        return name;
    }
}
