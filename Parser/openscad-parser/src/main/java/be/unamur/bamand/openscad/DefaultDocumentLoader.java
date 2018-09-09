package be.unamur.bamand.openscad;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.TokenStream;

import be.unamur.bamand.openscad.ast.Document;
import be.unamur.bamand.openscad.ast.DocumentLoader;

public class DefaultDocumentLoader implements DocumentLoader {

    private CommentList commentsList;

    @Override
    public void load(String name, String currentDocument, Document doc) {
        // TODO openscad path
        File f = new File(name);
        if (!f.exists())
            f = new File(new File(currentDocument).getParentFile(), name);
        try {
            parse(new FileInputStream(f), doc);
        } catch (IOException e) {
            // TODO Auto-generated catch block
            throw new RuntimeException(e);
        }
    }

    public void parse(InputStream in, Document doc) throws IOException {
        ANTLRInputStream input = new ANTLRInputStream(in);
        OpenSCADLexer lexer = new OpenSCADLexer(input);
        TokenStream tokens = new CommonTokenStream(lexer);
        OpenSCADParser parser = new OpenSCADParser(tokens);
        commentsList = new CommentList();

        lexer.setCommentObserver(commentsList);
        parser.input(doc);
    }

    public Document load(String document) {
        DefaultDocument doc = new DefaultDocument(document, this);
        load(document, document, doc);
        return doc;
    }

    public Document parse(InputStream in, String name) throws IOException {
        DefaultDocument doc = new DefaultDocument(name, this);
        parse(in, doc);
        return doc;
    }

    public CommentList getCommentsList() {
        return commentsList;
    }
}
