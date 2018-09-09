package be.unamur.bamand.openscad;

import be.unamur.bamand.openscad.ast.Document;

/**
 * Created by Benoit Amand on 04-07-16.
 */
public class InvalidOpenscadDocumentException extends RuntimeException {

    public InvalidOpenscadDocumentException(String s) {
        super(s);
    }

    public InvalidOpenscadDocumentException(String s, Document document) {
        super("[" + document.getName() + "] " + s);
    }
}
