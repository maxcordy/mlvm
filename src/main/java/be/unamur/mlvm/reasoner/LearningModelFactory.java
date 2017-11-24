package be.unamur.mlvm.reasoner;

@FunctionalInterface
public interface LearningModelFactory {
    LearningModel create(int capacity);
}
