package be.unamur.bamand.openscad.ast;

public interface Document extends Scope {
	void use(String path);

	void include(String path);

	String getName();
}
