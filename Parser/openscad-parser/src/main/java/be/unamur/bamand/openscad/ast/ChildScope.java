package be.unamur.bamand.openscad.ast;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;


public class ChildScope implements Instruction, Scope {
    private List<VariableDefinition> vars = new ArrayList<>();
    private List<Instruction> instructions = new ArrayList<>();

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

    @Override
    public void defineModule(ModuleDefinition module) {
        throw new RuntimeException("ChildScope cannot hold a module");
    }

    @Override
    public void defineFunction(FunctionDefinition function) {
        throw new RuntimeException("ChildScope cannot hold a function");
    }

    @Override
    public void defineVariable(VariableDefinition variable) {
        vars.add(variable);
    }

    @Override
    public void appendInstruction(Instruction instr) {
        if (instr != null) {
            instructions.add(instr);
        }
    }

    @Override
    public Stream<Instruction> getInstructions() {
        return instructions.stream();
    }

    @Override
    public Stream<VariableDefinition> getLocalVariables() {
        return vars.stream();
    }

    @Override
    public Stream<FunctionDefinition> getLocalFunctions() {
        return Stream.empty();
    }

    @Override
    public Stream<ModuleDefinition> getLocalModules() {
        return Stream.empty();
    }
}
