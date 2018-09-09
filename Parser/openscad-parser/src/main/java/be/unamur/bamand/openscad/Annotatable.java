package be.unamur.bamand.openscad;

import be.unamur.bamand.openscad.ast.Scope;

public interface Annotatable {
	Scope getScope();

	void setComment(String comment);

	String getName();
}
