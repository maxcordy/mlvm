package be.unamur.bamand.openscad.ast;

import edu.emory.mathcs.backport.java.util.Collections;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;

public class ModuleDefinition implements Scope, ASTNode {

    private String name;
    private List<Parameter> params;
    private List<VariableDefinition> vars = new ArrayList<>();
    private List<FunctionDefinition> fns = new ArrayList<>();
    private List<ModuleDefinition> mods = new ArrayList<>();
    private List<Instruction> instructions = new ArrayList<>();
    private Scope parentScope;

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

    public ModuleDefinition(Scope scope, String name, ArrayList<Parameter> params) {
        this.parentScope = scope;
        this.name = name;
        this.params = params != null ? params : Collections.emptyList();
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
        return fns.stream();
    }

    @Override
    public Stream<ModuleDefinition> getLocalModules() {
        return mods.stream();
    }

    @Override
    public void defineModule(ModuleDefinition module) {
        mods.add(module);
    }

    @Override
    public void defineFunction(FunctionDefinition function) {
        fns.add(function);
    }

    public String getName() {
        return name;
    }

    public List<Parameter> getParameters() {
        return params;
    }
}
