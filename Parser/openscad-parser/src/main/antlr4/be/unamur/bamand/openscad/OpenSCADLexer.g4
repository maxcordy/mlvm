lexer grammar OpenSCADLexer;

@header {
	import java.util.ArrayList;
	import be.unamur.bamand.openscad.CommentObserver;
}

@members {
	private CommentObserver observer;

	public void setCommentObserver(CommentObserver observer) {
		this.observer = observer;
	}

	private int commentStartLine, commentStartChar;
	private int commentEndLine, commentEndChar;
	
	private void setComment(boolean multiline, String comment) {
		observer.addComment(comment, multiline, commentStartLine, commentStartChar, commentEndLine, commentEndChar);
	}
}

WS
:
	[ \t]+ -> skip
;

NL
:
	(
		'\r' '\n'?
		| '\n'
	) -> skip
;

MULTILINE_COMMENT
:
	'/*'
	{ 
		commentStartLine = getLine();
		commentStartChar = getCharPositionInLine() - 2;
	}

	-> mode ( IN_MULTILINE_COMMENT ) , skip
;

COMMENT
:
	'//'
	{
		commentStartLine = getLine();
		commentStartChar = getCharPositionInLine() - 2;
	}

	-> mode ( IN_COMMENT ) , skip
;

SEMI
:
	';'
;

L_BRACE
:
	'{'
;

R_BRACE
:
	'}'
;

L_BRACKET
:
	'['
;

R_BRACKET
:
	']'
;

L_PAREN
:
	'('
;

R_PAREN
:
	')'
;

COMMA
:
	','
;

EQUAL
:
	'='
;

BANG
:
	'!'
;

PLUS
:
	'+'
;

MINUS
:
	'-'
;

STAR
:
	'*'
;

SLASH
:
	'/'
;

PERCENT
:
	'%'
;

SHARP
:
	'#'
;

QUESTION
:
	'?'
;

COLON
:
	':'
;

BOOL_OR
:
	'||'
;

BOOL_AND
:
	'&&'
;

OP_LEQ
:
	'<='
;

OP_GEQ
:
	'>='
;

OP_LT
:
	'<'
;

OP_GT
:
	'>'
;

OP_EQ
:
	'=='
;

OP_NE
:
	'!='
;

DOT
:
	'.'
;

TOK_USE : 'use' -> mode ( IN_USE ) ;

TOK_INCLUDE : 'include' -> mode ( IN_USE ) ;

TOK_MODULE
:
	'module'
;

TOK_FUNCTION
:
	'function'
;

TOK_IF
:
	'if'
;

TOK_ELSE
:
	'else'
;

TOK_LET
:
	'let'
;

TOK_FOR
:
	'for'
;

TOK_EACH
:
	'each'
;

TOK_TRUE
:
	'true'
;

TOK_FALSE
:
	'false'
;

TOK_UNDEF
:
	'undef'
;

TOK_STRING
:
	'"' ( ESC | ~[\\"] )* '"'
	{ setText(org.antlr.v4.misc.CharSupport.getStringFromGrammarStringLiteral(getText())); }

;

fragment ESC : '\\' . ;

TOK_FLOAT
:
	DEC+ EXP?
	| DEC* '.' DEC+ EXP?
	| DEC+ '.' DEC* EXP?
;

fragment
DEC
:
	[0-9]
;

fragment
EXP
:
	[Ee] [+-]? DEC+
;

TOK_ID
:
	'$'? [a-zA-Z0-9_]+
;

mode IN_USE;

WS2 : [ \t]+ -> skip;

TOK_USE_START : '<';
TOK_USE_STOP : '>' -> mode ( DEFAULT_MODE );
TOK_USE_NAME : ~('<'|'>')+;

mode IN_COMMENT;

COMMENT_CONTENT
:
	~[\r\n]* [\r\n]?
	{
		commentEndLine = getLine();
		commentEndChar = getCharPositionInLine();
		setComment(false, getText().replaceAll("[\r\n]*$", ""));
	}

	-> mode ( DEFAULT_MODE ) , skip
;

COMMENT_NO_CONTENT
:
	[\r\n] -> skip
;

mode IN_MULTILINE_COMMENT;

MUTLILINE_COMMENT_CONTENT
:
	.*? '*/'
	{
	  	commentEndLine = getLine(); 
		commentEndChar = getCharPositionInLine();
		String x = getText();
		setComment(true, x.substring(0, x.length() - 2));
	}

	-> mode ( DEFAULT_MODE ) , skip
;