package be.unamur.mlvm.vm;

import java.util.Map;
import java.util.Set;

public interface Constraint {
    boolean fulfil(Configuration configuration);
}
