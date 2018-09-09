package be.unamur.bamand.openscad.ast;

public class ElementGenerator implements Generator {
    private Expression element;

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

    public ElementGenerator(Expression element) {
        this.element = element;
    }

    public Expression getElement() {
        return element;
    }
}
