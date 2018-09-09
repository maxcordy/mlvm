package be.unamur.bamand.openscad;

public interface CommentObserver {

	void addComment(String comment, boolean multiline, int fromLine, int fromChar, int toLine, int toChar);
}
