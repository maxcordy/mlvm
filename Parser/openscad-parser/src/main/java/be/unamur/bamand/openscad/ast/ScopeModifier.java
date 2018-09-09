package be.unamur.bamand.openscad.ast;

public class ScopeModifier implements Instruction {

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
        startLocation=start;
        endLocation =end;
    }

    public enum ModifierType {
        ROOT, DEBUG, BACKGROUND, DISABLED
    }

    private ModifierType type;
    private Instruction child;

    public ScopeModifier(ModifierType type, Instruction child) {
        this.type = type;
        this.child = child;
    }


    public ModifierType getType() {
        return type;
    }
    public Instruction getChild() {
        return child;
    }

}
