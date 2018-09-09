package be.unamur.bamand.openscad;

import be.unamur.bamand.openscad.ast.*;
import org.antlr.v4.runtime.misc.NotNull;

import java.util.stream.Collectors;
import java.util.stream.Stream;

public class AstPrinter {


    private Mapper<Instruction, String> instructionStringVisitor;
    private Mapper<Expression, String> expressionStringVisitor;
    private Mapper<Generator, String> generatorStringVisitor;

    public AstPrinter() {
        instructionStringVisitor = Mapper.<Instruction, String>create()
                .with(Condition.class, this::conditionToString)
                .with(ModuleInstantiation.class, this::modInstToString)
                .with(ScopeModifier.class, this::scopeModifierToString)
                .with(ChildScope.class, this::scopeToString)
                .with(Instruction.class, instr -> {
                    throw new IllegalStateException("Unhandled instruction " + instr.getClass());
                });

        expressionStringVisitor = Mapper.<Expression, String>create()
                .with(FunctionCall.class, this::functionCallToString)
                .with(ArrayElement.class, this::arrayElementToString)
                .with(Vector.class, this::vectorToString)
                .with(GeneratorExpression.class, this::generatorToString)
                .with(UnaryOperation.class, this::unaryOperationToString)
                .with(Range.class, this::rangeToString)
                .with(BooleanOperation.class, this::booleanExpressionToString)
                .with(ArithmeticOperation.class, this::arithmeticOperationToString)
                .with(ObjectField.class, this::objectFieldToString)
                .with(Constant.class, this::constantToString)
                .with(Comparison.class, this::comparisonToString)
                .with(LetExpression.class, this::letExpressionToString)
                .with(Variable.class, Variable::getName)
                .with(TernaryCondition.class, this::ternaryOperationToString)
                .with(Expression.class, expression -> {
                    throw new IllegalStateException("Unhandled expression " + expression.getClass());
                });


        generatorStringVisitor = Mapper.<Generator, String>create()
                .with(ForRangeGenerator.class, this::forRangeGeneratorToString)
                .with(EachGenerator.class, gen -> "each " + generatorStringVisitor.visit(gen.getChild()).get())
                .with(ElementGenerator.class, gen -> expressionStringVisitor.visit(gen.getElement()).get())
                .with(ForGenerator.class, gen -> "for(" + argumentsToString(gen.getInit().stream())
                        + " ; " + expressionStringVisitor.visit(gen.getCondition()).get()
                        + " ; " + argumentsToString(gen.getIncr().stream())
                        + ") " + generatorStringVisitor.visit(gen.getChild()).get())
                .with(LetGenerator.class, gen -> "let(" + argumentsToString(gen.getArgs().stream())
                        + ") " + generatorStringVisitor.visit(gen.getChild()).get())
                .with(ConditionGenerator.class, gen -> "( if(" + expressionStringVisitor.visit(gen.getCondition()).get()
                        + ") " + generatorStringVisitor.visit(gen.getThen()).get()
                        + " )")
                .with(Generator.class, generator -> {
                    throw new IllegalStateException("Unhandled generator " + generator.getClass());
                });
    }

    private String constantToString(Constant t) {
        switch (t.getType()) {

            case BOOL:
                return t.getValue().toString();
            case STRING:
                return '"' + t.getValue().toString().replaceAll("[\\\\\"]", "\\$1") + '"';
            case FLOAT:
                return t.getValue().toString();
            case UNDEF:
            default:
                return "undef";
        }
    }

    public void print(Document doc) {
        System.out.println(scopeContentToString(doc));
    }

    public String toString(Expression expression) {
        return expressionStringVisitor.visit(expression).orElse(null);
    }

    @NotNull
    private String forRangeGeneratorToString(ForRangeGenerator forRangeGenerator) {
        return "for(" + forRangeGenerator.getArgs().stream().map(arg ->
                arg.getName() + "=" + expressionStringVisitor.visit(arg.getValue()).get()
        ).collect(Collectors.joining(", ")) + ")" + generatorStringVisitor.visit(forRangeGenerator.getChild()).get();
    }

    @NotNull
    private String ternaryOperationToString(TernaryCondition tc) {
        return "(" + expressionStringVisitor.visit(tc.getCondition()).get() +
                " ? " + expressionStringVisitor.visit(tc.getTruthyValue()).get() +
                " : " + expressionStringVisitor.visit(tc.getFalseyValue()).get() + ")";
    }

    @NotNull
    private String letExpressionToString(LetExpression let) {
        return "let(" + argumentsToString(let.getArgs().stream()) + ")"
                + expressionStringVisitor.visit(let.getChild()).get();
    }

    @NotNull
    private String comparisonToString(Comparison c) {
        return "(" + expressionStringVisitor.visit(c.getLeft()).get()
                + " " + c.getOperator().getSymbol() + " "
                + expressionStringVisitor.visit(c.getRight()).get()
                + ")";
    }

    @NotNull
    private String objectFieldToString(ObjectField objField) {
        return "(" + expressionStringVisitor.visit(objField.getObject()).get() + ")."
                + objField.getField();
    }

    @NotNull
    private String arithmeticOperationToString(ArithmeticOperation aOp) {
        return "(" + expressionStringVisitor.visit(aOp.getLeft()).get()
                + " " + aOp.getOperator().getSymbol() + " "
                + expressionStringVisitor.visit(aOp.getRight()).get()
                + ")";
    }

    @NotNull
    private String booleanExpressionToString(BooleanOperation boolOp) {
        return "(" + expressionStringVisitor.visit(boolOp.getLeft()).get()
                + " " + boolOp.getOperator().getSymbol() + " "
                + expressionStringVisitor.visit(boolOp.getRight()).get()
                + ")";
    }

    @NotNull
    private String rangeToString(Range range) {
        return "[" + expressionStringVisitor.visit(range.getStart()).get()
                + (range.getIncrement() != null ? " : " + expressionStringVisitor.visit(range.getIncrement()).get() : "")
                + " : " + expressionStringVisitor.visit(range.getEnd()).get()
                + "]";
    }

    @NotNull
    private String unaryOperationToString(UnaryOperation unOp) {
        return "(" + unOp.getOperator().getSymbol() + expressionStringVisitor.visit(unOp.getExpr()).get() + ")";
    }

    @NotNull
    private String vectorToString(Vector vec) {
        return "[" +
                vec.getElements().stream().map(
                        gen -> expressionStringVisitor.visit(gen).get()
                ).collect(Collectors.joining(", ")) + "]";
    }

    @NotNull
    private String generatorToString(GeneratorExpression gen) {
        return "[" + generatorStringVisitor.visit(gen.getGenerator()).get() + "]";
    }

    @NotNull
    private String arrayElementToString(ArrayElement ae) {
        return "(" + expressionStringVisitor.visit(ae.getArray()).get() + ")" +
                "[" + ae.getElement() + "]";
    }

    @NotNull
    private String functionCallToString(FunctionCall fc) {
        if (fc.getArguments() == null) {
            System.out.println("here");
        }
        return fc.getName() + "(" + argumentsToString(fc.getArguments().stream()) + ")";
    }


    private String paramsToString(Stream<Parameter> parameters) {
        return parameters.map(
                param -> param.getName() + (param.getDefaultValue() != null ?
                        "=" + expressionStringVisitor.visit(param.getDefaultValue()).get() : "")
        ).collect(Collectors.joining(", "));
    }

    private String argumentsToString(Stream<Argument> arguments) {
        return arguments.map(
                arg -> (arg.getName() != null ? arg.getName() + "=" : "")
                        + expressionStringVisitor.visit(arg.getValue()).get())
                .collect(Collectors.joining(", "));
    }

    private String scopeContentToString(Scope scope) {
        String str = "";

        Stream<VariableDefinition> localVariables = scope.getLocalVariables();
        if (localVariables != null)
            str += localVariables.map(var -> var.getName() + " = " + expressionStringVisitor.visit(var.getValue()).get() + ";\n")
                    .collect(Collectors.joining());

        Stream<ModuleDefinition> localModules = scope.getLocalModules();
        if (localModules != null)
            str += localModules.map(def -> def.getName() + "(" + (def.getParameters() != null ?
                    paramsToString(def.getParameters().stream()) : "")
                    + ") " + scopeToString(def) + "\n")
                    .collect(Collectors.joining());

        Stream<FunctionDefinition> localFunctions = scope.getLocalFunctions();
        if (localFunctions != null)
            str += localFunctions.map(def -> def.getName() + "(" + paramsToString(def.getParameters().stream())
                    + ") = " + expressionStringVisitor.visit(def.getBody()).get() + ";\n")
                    .collect(Collectors.joining());

        str += scope.getInstructions().map(instr -> instructionStringVisitor.visit(instr).get())
                .collect(Collectors.joining("\n"));
        return str;
    }

    private String scopeToString(Scope scope) {
        return "{\n\t" + scopeContentToString(scope).replaceAll("\n", "\n\t") + "\n}";
    }

    private String scopeModifierToString(ScopeModifier scopeModifier) {
        String str = "";
        switch (scopeModifier.getType()) {
            case ROOT:
                str += "!";
                break;
            case DEBUG:
                str += "#";
                break;
            case BACKGROUND:
                str += "%";
                break;
            case DISABLED:
                str += "*";
                break;
        }
        str += " {\n\t";
        instructionStringVisitor.visit(scopeModifier.getChild()).get()
                .replaceAll("\n", "\n\t");
        str += "\n}";
        return str;
    }

    private String conditionToString(Condition condition) {
        String str = "if(" + expressionStringVisitor.visit(condition.getCondition()).get() + ") {\n\t";
        str += instructionStringVisitor.visit(condition.getIfClause())
                .get().replaceAll("\n", "\n\t");

        if (condition.getElseClause() != null) {
            str += "\n} else {\n\t";
            str += instructionStringVisitor.visit(condition.getElseClause())
                    .get()
                    .replaceAll("\n", "\n\t");
        }
        return str + "\n}";
    }

    private String modInstToString(ModuleInstantiation module) {
        String str = module.getName() + "(" + argumentsToString(module.getArguments().stream()) + ")";
        if (module.getChild() != null) {
            str += " {\n\t";
            str += instructionStringVisitor.visit(module.getChild())
                    .get().replaceAll("\n", "\n\t");
            str += "\n}";
        } else
            str += ";";
        return str;
    }
}
