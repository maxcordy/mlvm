package be.unamur.bamand.openscad;

import be.unamur.bamand.openscad.ast.Location;
import be.unamur.bamand.openscad.ast.VariableDefinition;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class Parameters {

    private final List<Parameter> parameters;

    public Parameters(Stream<VariableDefinition> parameters) {
        this.parameters = parameters.map(Parameter::new).collect(Collectors.toList());
    }

    public void addSectionSeparator(Location location, String section) {
        this.parameters.forEach(p -> {
            if(p.getLocation().compareTo(location) >= 0)
                p.setSection(section);
        });
    }

    public void addComment(VariableDefinition def, String text, CommentPosition position) {
        this.parameters.stream().filter(x -> x.getDefinition().equals(def))
                .findFirst().get().addComment(text, position);
    }

    public List<Parameter> getParameters() {
        return parameters;
    }
}
