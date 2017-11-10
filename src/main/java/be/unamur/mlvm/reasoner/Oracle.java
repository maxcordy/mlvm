package be.unamur.mlvm.reasoner;

import be.unamur.mlvm.vm.Configuration;

/**
 * @author mcr
 */
public interface Oracle {
    
    public boolean isValid(Configuration c);
    
}
