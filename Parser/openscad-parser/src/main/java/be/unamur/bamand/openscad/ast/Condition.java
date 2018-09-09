package be.unamur.bamand.openscad.ast;

public class Condition implements Instruction {
    private Expression condition;
    private Instruction ifClause;
    private Instruction elseClause;

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

    public Condition(Expression condition, Instruction ifClause, Instruction elseClause) {
        this.condition = condition;
        this.ifClause = ifClause;
        this.elseClause = elseClause;
    }

    public Expression getCondition() {
        return condition;
    }

    public Instruction getIfClause() {
        return ifClause;
    }

    public Instruction getElseClause() {
        return elseClause;
    }

    public void setElseClause(Instruction elseClause) {
        this.elseClause = elseClause;
    }
}
