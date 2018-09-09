package be.unamur.bamand.openscad.ast;

import java.util.stream.Stream;

public interface Scope {
    void defineModule(ModuleDefinition module);

    void defineFunction(FunctionDefinition function);

    void defineVariable(VariableDefinition variable);

    void appendInstruction(Instruction instr);

    Stream<Instruction> getInstructions();

    Stream<VariableDefinition> getLocalVariables();

    Stream<FunctionDefinition> getLocalFunctions();

    Stream<ModuleDefinition> getLocalModules();
}
