package be.unamur.bamand.openscad.ast;

/**
 * Created by amand on 04-04-17.
 */
public interface ASTNode {
    Location getStartLocation();
    Location getEndLocation();
    void setLocation(Location start, Location end);
}

