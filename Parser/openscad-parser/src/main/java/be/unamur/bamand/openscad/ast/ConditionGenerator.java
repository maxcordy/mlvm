package be.unamur.bamand.openscad.ast;

public class ConditionGenerator implements Generator {
    private Expression condition;
    private Generator then;
//    private Generator otherwise;

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

    public ConditionGenerator(Expression condition, Generator ifClause) {
        this.condition = condition;
        this.then = ifClause;
    }

//    public ConditionGenerator(Expression condition, Generator then, Generator otherwise) {
//        this.condition = condition;
//        this.then = then;
//        this.otherwise = otherwise;
//    }

    public Expression getCondition() {
        return condition;
    }

    public Generator getThen() {
        return then;
    }

//    public Generator getOtherwise() {
//        return otherwise;
//    }
}
