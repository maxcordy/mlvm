package be.unamur.bamand.openscad.ast;

public class Location implements Comparable<Location> {
    private int line, column;

    public Location(int line, int column) {
        this.line = line;
        this.column = column;
    }

    public int getLine() {
        return line;
    }

    public int getColumn() {
        return column;
    }

    @Override
    public int compareTo(Location o) {
        return line != o.line ? line - o.line : column - o.column;
    }

    @Override
    public String toString() {
        return line + ":" + column;
    }
}
