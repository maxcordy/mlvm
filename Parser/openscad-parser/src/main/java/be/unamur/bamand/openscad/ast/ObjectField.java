package be.unamur.bamand.openscad.ast;

public class ObjectField implements Expression {

    private Expression object;
    private String field;

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

    public ObjectField(Expression object, String field) {
        this.object = object;
        this.field = field;
    }

    public Expression getObject() {
        return object;
    }

    public String getField() {
        return field;
    }
}
