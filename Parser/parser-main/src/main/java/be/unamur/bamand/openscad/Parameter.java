package be.unamur.bamand.openscad;

import be.unamur.bamand.openscad.ast.Location;
import be.unamur.bamand.openscad.ast.VariableDefinition;

import java.util.EnumMap;

public class Parameter {
    private final VariableDefinition definition;
    private String section;
    private EnumMap<CommentPosition, String> comments = new EnumMap<>(CommentPosition.class);
    private String description;
    private String constraints;
    private ScadType defaultType;


    public Parameter(VariableDefinition definition) {
        this.definition = definition;
    }

    public Object getName() {
        return definition.getName();
    }

    public Location getLocation() {
        return definition.getStartLocation();
    }

    public String getSection() {
        return section;
    }

    public String getDescription() {
        return description;
    }

    public Object getConstraints() {
        return this.constraints;
    }

    public Object getDefault() {
        return new AstPrinter().toString(this.definition.getValue());
    }

    public VariableDefinition getDefinition() {
        return definition;
    }

    public void setSection(String section) {
        this.section = section;
    }

    public void addComment(String text, CommentPosition position) {
        this.comments.put(position, text);
    }

    public String getComment(CommentPosition x) {
        return this.comments.get(x);
    }

    public void removeComment(CommentPosition x) {
        this.comments.remove(x);
    }

    public void analyzeComments() {
        if (this.comments.containsKey(CommentPosition.LineAbove))
            this.description = this.comments.get(CommentPosition.LineAbove);

        if (this.comments.containsKey(CommentPosition.SameLine))
            this.constraints = this.comments.get(CommentPosition.SameLine);
    }

    public ScadType getDefaultType() {
        return defaultType;
    }

    public void setDefaultType(ScadType defaultType) {
        this.defaultType = defaultType;
    }
}
