package be.unamur.bamand.openscad;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

import be.unamur.bamand.openscad.ast.*;

public class DefaultDocument implements Document {

    private DocumentLoader loader;
    private String documentPath;
    private List<VariableDefinition> vars = new ArrayList<>();
    private List<FunctionDefinition> fns = new ArrayList<>();
    private List<ModuleDefinition> mods = new ArrayList<>();
    private List<Instruction> instructions = new ArrayList<>();

    public DefaultDocument(String document, DocumentLoader loader) {
        this.documentPath = document;
        this.loader = loader;
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
    public void defineModule(ModuleDefinition module) {
        mods.add(module);
    }

    @Override
    public void defineFunction(FunctionDefinition function) {
        fns.add(function);
    }

    @Override
    public void use(String path) {
        try {
            loader.load(path, documentPath, new UseDocumentProxy(this));
        } catch (Exception e) {
            // ignore unresolved imports
        }
    }

    @Override
    public void include(String path) {
        try {
            loader.load(path, documentPath, this);
        } catch (Exception e) {
            // ignore unresolved imports
        }
    }

    @Override
    public String getName() {
        return documentPath;
    }

    private static class UseDocumentProxy implements Document {
        private Document doc;

        public UseDocumentProxy(Document doc) {
            this.doc = doc;
        }

        @Override
        public void defineVariable(VariableDefinition variable) {
        }

        @Override
        public void appendInstruction(Instruction instr) {
        }

        @Override
        public Stream<Instruction> getInstructions() {
            return null;
        }

        @Override
        public Stream<VariableDefinition> getLocalVariables() {
            return null;
        }

        @Override
        public void defineModule(ModuleDefinition module) {
            doc.defineModule(module);
        }

        @Override
        public void defineFunction(FunctionDefinition function) {
            doc.defineFunction(function);
        }

        @Override
        public void use(String path) {
            doc.use(path);
        }

        @Override
        public void include(String path) {
            doc.include(path);
        }

        @Override
        public String getName() {
            return doc.getName();
        }

        @Override
        public Stream<FunctionDefinition> getLocalFunctions() {
            return doc.getLocalFunctions();
        }

        @Override
        public Stream<ModuleDefinition> getLocalModules() {
            return doc.getLocalModules();
        }
    }

    @Override
    public Stream<FunctionDefinition> getLocalFunctions() {
        return fns.stream();
    }

    @Override
    public Stream<ModuleDefinition> getLocalModules() {
        return mods.stream();
    }
}
