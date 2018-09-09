package be.unamur.bamand.openscad;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

public class CommentList implements CommentObserver {
    private List<Comment> comments = new ArrayList<>();

    @Override
    public void addComment(String comment, boolean multiline, int fromLine, int fromChar, int toLine, int toChar) {
        Comment area = new Comment(multiline, fromLine, fromChar, toLine, toChar, comment);
        comments.add(area);
    }

    public Stream<Comment> getAll() {
        return comments.stream();
    }

    public static class Comment implements Comparable<Comment> {
        public final String text;
        public final boolean multiline;
        public final int fromLine, fromChar, toLine, toChar;

        public Comment(boolean multiline, int fromLine, int fromChar, int toLine, int toChar, String t) {
            this.text = t;
            this.multiline = multiline;
            this.fromLine = fromLine;
            this.fromChar = fromChar;
            this.toLine = toLine;
            this.toChar = toChar;
        }

        @Override
        public int compareTo(Comment o) {
            return fromLine != o.fromLine ?
                    Integer.compare(fromLine, o.fromLine)
                    : Integer.compare(fromChar, o.fromChar);
        }

        @Override
        public String toString() {
            return "{" +
                    "from=" + fromLine + ":" + fromChar +
                    ", to=" + toLine + ":" + toChar +
                    ", " + text +
                    "}";
        }
    }
}
