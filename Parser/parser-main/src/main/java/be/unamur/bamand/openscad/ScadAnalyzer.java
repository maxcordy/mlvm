package be.unamur.bamand.openscad;

import be.unamur.bamand.openscad.ast.*;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.List;

public class ScadAnalyzer {
    private final Document doc;
    private final SourceMap map;
    private final Parameters parameters;

    public ScadAnalyzer(String filename, String content) throws IOException {
        DefaultDocumentLoader loader = new DefaultDocumentLoader();
        this.doc = loader.parse(new ByteArrayInputStream(content.getBytes()),
                filename);

        this.map = new SourceMap(doc);
        this.parameters = new Parameters(doc.getLocalVariables().filter(ScadAnalyzer::isParameter));

        loader.getCommentsList().getAll().forEach(this::processComment);
        this.parameters.getParameters().forEach(this::processParameter);
    }

    private void processParameter(Parameter parameter) {
        parameter.analyzeComments();
        VariableDefinition def = parameter.getDefinition();
            parameter.setDefaultType(getDeclarationType(def.getValue()));
    }

    private void processComment(CommentList.Comment comment) {
        if (comment.multiline && comment.fromLine == comment.toLine) {
            String text = comment.text.trim();
            if (text.startsWith("[") && text.endsWith("]")) {
                parameters.addSectionSeparator(
                        new Location(comment.fromLine, comment.fromChar),
                        text.substring(1, text.length() - 1).trim());
                return;
            }
        }

        ASTNode before = map.getNodeBefore(new Location(comment.fromLine, comment.fromChar));
        ASTNode after = map.getNodeAfter(new Location(comment.toLine, comment.toChar));

        if (before != null && before.getEndLocation().getLine() == comment.fromLine) {
            // same line comment
            if (isParameter(before))
                parameters.addComment((VariableDefinition) before, comment.text, CommentPosition.SameLine);
        } else if (after != null && after.getStartLocation().getLine() <= comment.toLine + 1) {
            // line after comment
            if (isParameter(after))
                parameters.addComment((VariableDefinition) after, comment.text, CommentPosition.LineAbove);
        } else if (before != null && before.getEndLocation().getLine() == comment.fromLine) {
            // line before comment
            if (isParameter(before))
                parameters.addComment((VariableDefinition) before, comment.text, CommentPosition.LineUnderneath);
        }
    }

    private static boolean isParameter(ASTNode x) {
        return (x instanceof VariableDefinition) && isParameterDeclaration(((VariableDefinition) x).getValue());
    }

    private static boolean isParameterDeclaration(Expression value) {
        return declarationExpressionVisitor.visit(value).orElse(false);
    }

    private static final Mapper<Expression, Boolean> declarationExpressionVisitor = Mapper.<Expression, Boolean>create()
            .with(Vector.class, x -> x.getElements().stream().allMatch(ScadAnalyzer::isParameterDeclaration))
            .with(UnaryOperation.class, uo -> isParameterDeclaration(uo.getExpr()) && uo.getOperator() != UnaryOperator.NOT)
            .with(Range.class, r -> isParameterDeclaration(r.getStart()) && isParameterDeclaration(r.getEnd()) &&
                    (r.getIncrement() == null || isParameterDeclaration(r.getIncrement())))

            .with(Constant.class, c -> true)

            .with(Comparison.class, x -> false)
            .with(LetExpression.class, x -> false)
            .with(Variable.class, x -> false)
            .with(TernaryCondition.class, x -> false)
            .with(GeneratorExpression.class, c -> false)
            .with(FunctionCall.class, x -> false)
            .with(ArrayElement.class, x -> false)
            .with(ArithmeticOperation.class, x -> false)
            .with(BooleanOperation.class, x -> false)
            .with(ObjectField.class, x -> false)

            .with(Expression.class, expression -> {
                throw new IllegalStateException("Unhandled expression " + expression.getClass());
            });

    private static ScadType getDeclarationType(Expression value) {
        return declarationTypeVisitor.visit(value).orElse(null);
    }


    private static final Mapper<Expression, ScadType> declarationTypeVisitor = Mapper.<Expression, ScadType>create()
            .with(Vector.class, x ->
                        x.getElements().stream().map(ScadAnalyzer::getDeclarationType)
                                .reduce(ScadType::unionWith).orElse(new ScadType(ScadType.Type.Array, ScadType.Mixed))
            )
            .with(UnaryOperation.class, uo -> getDeclarationType(uo.getExpr()))
            .with(Range.class, r -> new ScadType(ScadType.Type.Array, getDeclarationType(r.getStart())))

            .with(Constant.class, c -> {
                switch(c.getType()) {
                    case BOOL:
                        return ScadType.Mixed;
                    case STRING:
                        return ScadType.String;
                    case FLOAT:
                        return ScadType.Float;
                    case UNDEF:
                        default:
                        return ScadType.Undef;
                }
            })
            .with(Expression.class, expression -> {
                throw new IllegalStateException("Unhandled expression " + expression.getClass());
            });


    public List<Parameter> getParameters() {
        return parameters.getParameters();
    }
}


