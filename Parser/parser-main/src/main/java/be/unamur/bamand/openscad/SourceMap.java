package be.unamur.bamand.openscad;

import be.unamur.bamand.openscad.ast.ASTNode;
import be.unamur.bamand.openscad.ast.Document;
import be.unamur.bamand.openscad.ast.Instruction;
import be.unamur.bamand.openscad.ast.Location;

import java.util.Map;
import java.util.TreeMap;

public class SourceMap {
    private TreeMap<SourceRange, ASTNode> forwardMap = new TreeMap<>(SourceRange::compareStart);
    private TreeMap<SourceRange, ASTNode> backwardMap = new TreeMap<>(SourceRange::compareEnd);

    public SourceMap(Document doc) {
        doc.getInstructions().forEach(i -> put(new SourceRange(i), i));
        doc.getLocalVariables().forEach(i -> put(new SourceRange(i), i));
        doc.getLocalFunctions().forEach(i -> put(new SourceRange(i), i));
        doc.getLocalModules().forEach(i -> put(new SourceRange(i), i));
    }

    private void put(SourceRange r, ASTNode n) {
        forwardMap.put(r, n);
        backwardMap.put(r, n);
    }

    public ASTNode getNodeBefore(Location l) {
        Map.Entry<SourceRange, ASTNode> x = backwardMap.floorEntry(new SourceRange(l, l));
        return x != null ? x.getValue() : null;
    }

    public ASTNode getNodeAfter(Location l) {
        Map.Entry<SourceRange, ASTNode> x = forwardMap.ceilingEntry(new SourceRange(l, l));
        return x != null ? x.getValue() : null;
    }


    public static class SourceRange {
        public final Location from, to;

        public SourceRange(Location from, Location to) {
            this.from = from;
            this.to = to;
        }

        public SourceRange(ASTNode node) {
            this(node.getStartLocation(), node.getEndLocation());
        }

        public static int compareStart(SourceRange a, SourceRange b) {
            int k = a.from.compareTo(b.from);
            return k != 0 ? k : a.to.compareTo(b.to);
        }

        public static int compareEnd(SourceRange a, SourceRange b) {
            int k = a.to.compareTo(b.to);
            return k != 0 ? k : a.from.compareTo(b.from);
        }
    }

    public static class CommentNode implements ASTNode {
        private final Location start;
        private final Location end;

        public CommentNode(CommentList.Comment c) {
            start = new Location(c.fromLine, c.fromChar);
            end = new Location(c.toLine, c.toChar);
        }

        @Override
        public Location getStartLocation() {
            return start;
        }

        @Override
        public Location getEndLocation() {
            return end;
        }

        @Override
        public void setLocation(Location start, Location end) {

        }
    }
}
