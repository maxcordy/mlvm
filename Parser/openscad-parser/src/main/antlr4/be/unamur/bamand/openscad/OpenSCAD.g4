grammar OpenSCAD;

options { tokenVocab=OpenSCADLexer; }

@header {
	import java.util.ArrayList;
	import be.unamur.bamand.openscad.ast.*;
}

@members {
	private <T extends ASTNode> T L(ParserRuleContext ctx, T node) {
		Token firstToken = ctx.getStart();
		Token lastToken = ctx.getStop();
		if(lastToken == null) lastToken = firstToken;
		Location start = new Location(firstToken.getLine(), firstToken.getCharPositionInLine() + 1);
		Location end = new Location(lastToken.getLine(), firstToken.getCharPositionInLine() + 1);
		node.setLocation(start, end);
		return node;
	}
}

input[Document document]
:   (	TOK_USE TOK_USE_START TOK_USE_NAME TOK_USE_STOP { $document.use($TOK_USE_NAME.getText()); }
    |   TOK_INCLUDE TOK_USE_START TOK_USE_NAME TOK_USE_STOP { $document.include($TOK_USE_NAME.getText()); }
    |   statement [document]
    )*
;

statement [Scope scope]
        @init {
            ModuleDefinition module;
        }
:	SEMI
|   L_BRACE innerInput [scope] R_BRACE
|   moduleInstantiation {   $scope.appendInstruction($moduleInstantiation.instr); }
|   assignment [scope]
|   TOK_MODULE TOK_ID L_PAREN parameters COMMA* R_PAREN
        {
            module = L($ctx, new ModuleDefinition(scope, $TOK_ID.getText(), $parameters.params));
            $scope.defineModule(module);
        }
    statement [module]
| TOK_FUNCTION TOK_ID L_PAREN parameters COMMA* R_PAREN EQUAL expression SEMI
        { scope.defineFunction(L($ctx, new FunctionDefinition($TOK_ID.getText(), $parameters.params, $expression.expr))); }
;

innerInput [Scope scope]
:	( statement [scope] )*
;

assignment [Scope scope]
:	TOK_ID EQUAL expression x = SEMI
        {
            scope.defineVariable(L($ctx, new VariableDefinition($TOK_ID.getText(), $expression.expr)));
        }
;

moduleInstantiation returns [Instruction instr]
:	BANG x=moduleInstantiation
	    { $instr = L($ctx, new ScopeModifier(ScopeModifier.ModifierType.ROOT, $x.instr)); }
|   SHARP x=moduleInstantiation
    	{ $instr = L($ctx, new ScopeModifier(ScopeModifier.ModifierType.DEBUG, $x.instr)); }
|   PERCENT x=moduleInstantiation
	    { $instr = L($ctx, new ScopeModifier(ScopeModifier.ModifierType.BACKGROUND, $x.instr)); }
|   STAR x=moduleInstantiation
	    { $instr = L($ctx, new ScopeModifier(ScopeModifier.ModifierType.DISABLED, $x.instr)); }
|   singleModuleInstantiation childStatement
        {
            $instr = $singleModuleInstantiation.instr;
            if($childStatement.instr != null)
                $singleModuleInstantiation.instr.setChild($childStatement.instr);
        }
|   ifelseStatement
	    { $instr = $ifelseStatement.condition; }
;

ifelseStatement returns [Condition condition]
:	ifStatement
    	{ $condition = $ifStatement.condition; }
|   ifStatement TOK_ELSE childStatement
        {
            $condition = $ifStatement.condition;
            $ifStatement.condition.setElseClause($childStatement.instr);
        }

;

ifStatement returns [Condition condition]
:
	TOK_IF L_PAREN expression R_PAREN stat = childStatement
	{ $condition = L($ctx, new Condition($expression.expr, $stat.instr, null));}

;

childStatement returns [Instruction instr]
        @init {
            ChildScope block;
        }
:   SEMI { $instr = null; }
|   L_BRACE { block = L($ctx, new ChildScope()); $instr = block; }
    (   stat = childStatement { block.appendInstruction($stat.instr); }
    |   assignment [block]
    )*
    R_BRACE
|   moduleInstantiation { $instr = $moduleInstantiation.instr; }

;

// "for", "let" and "each" are valid module identifiers

moduleId returns [String name]
:   TOK_ID  { $name = $TOK_ID.getText(); }
|   TOK_FOR { $name = $TOK_FOR.getText(); }
|   TOK_LET { $name = $TOK_LET.getText(); }
|   TOK_EACH { $name = $TOK_EACH.getText(); }
;

singleModuleInstantiation returns [ModuleInstantiation instr]
:   moduleId L_PAREN arguments R_PAREN { $instr = L($ctx, new ModuleInstantiation($moduleId.name, $arguments.args)); }
;

expression returns [Expression expr]
:	condExpr { $expr = $condExpr.expr; }
|   TOK_LET L_PAREN arguments R_PAREN e1 = expression { $expr = L($ctx, new LetExpression($arguments.args, $e1.expr)); }
;

condExpr returns [Expression expr]
:	orExpr { $expr = $orExpr.expr; }
	(   QUESTION t = expression COLON f = condExpr { $expr = L($ctx, new TernaryCondition($orExpr.expr, $t.expr, $f.expr)); }
	)?
;

orExpr returns [Expression expr]
:	andExpr { $expr = $andExpr.expr; }
|   expr1 = orExpr BOOL_OR expr2 = andExpr
        { $expr = L($ctx, new BooleanOperation(BooleanOperator.OR, $expr1.expr, $expr2.expr)); }
;

andExpr returns [Expression expr]
:   compExpr { $expr = $compExpr.expr; }
| expr1 = andExpr BOOL_AND expr2 = compExpr
	{ $expr = L($ctx, new BooleanOperation(BooleanOperator.AND, $expr1.expr, $expr2.expr)); }
;

compExpr returns [Expression expr]
:	eqExpr { $expr = $eqExpr.expr; }
|   expr1 = compExpr op = comparisonOperator expr2 = eqExpr
	    { $expr = L($ctx, new Comparison($op.op, $expr1.expr, $expr2.expr)); }
;

eqExpr returns [Expression expr]
:   addExpr { $expr = $addExpr.expr; }
|   expr1 = eqExpr op = equalityOperator expr2 = addExpr
	    { $expr = L($ctx, new Comparison($op.op, $expr1.expr, $expr2.expr)); }
;

addExpr returns [Expression expr]
:	mulExpr { $expr = $mulExpr.expr; }
|   expr1 = addExpr op = addSubOperator expr2 = mulExpr
        { $expr = L($ctx, new ArithmeticOperation($op.op, $expr1.expr, $expr2.expr)); }
;

mulExpr returns [Expression expr]
:   unaryExpr { $expr = $unaryExpr.expr; }
|   expr1 = mulExpr op = mulDivModOperator expr2 = unaryExpr
	    { $expr = L($ctx, new ArithmeticOperation($op.op, $expr1.expr, $expr2.expr)); }
;

unaryExpr returns [Expression expr]
:	postfixExpr { $expr = $postfixExpr.expr; }
|   op = unaryOperator nexpr = unaryExpr { $expr = L($ctx, new UnaryOperation($op.op, $nexpr.expr)); }
;

postfixExpr returns [Expression expr]
:   primaryExpr { $expr = $primaryExpr.expr; }
|   expr1 = postfixExpr L_BRACKET expr2 = expression R_BRACKET { $expr = L($ctx, new ArrayElement($expr1.expr, $expr2.expr)); }
|   expr1 = postfixExpr DOT TOK_ID { $expr = L($ctx, new ObjectField($expr1.expr, $TOK_ID.getText())); }
|   TOK_ID L_PAREN arguments R_PAREN { $expr = L($ctx, new FunctionCall($TOK_ID.getText(), $arguments.args)); }
;

primaryExpr returns [Expression expr]
:   constantEpxr { $expr = $constantEpxr.expr; }
|   L_PAREN expression R_PAREN { $expr = $expression.expr; }
|   L_BRACKET expr1 = expression COLON expr2 = expression R_BRACKET { $expr = L($ctx, new Range($expr1.expr, $expr2.expr)); }
|   L_BRACKET expr1 = expression COLON expr2 = expression COLON expr3 = expression R_BRACKET
	    { $expr = L($ctx, new Range($expr1.expr, $expr2.expr, $expr3.expr)); }
|   L_BRACKET COMMA* R_BRACKET
	    { $expr = L($ctx, new Vector(new ArrayList<>())); }
|   L_BRACKET vectorOrGenerator COMMA* R_BRACKET
	    { $expr = $vectorOrGenerator.value; }
;

constantEpxr returns [Expression expr]
:	TOK_TRUE { $expr = L($ctx, new Constant(true)); }
|   TOK_FALSE { $expr = L($ctx, new Constant(false)); }
|   TOK_UNDEF { $expr = L($ctx, new Constant()); }
|   id = TOK_ID { $expr = L($ctx, new Variable($id.getText())); }
|   val = TOK_STRING { $expr = L($ctx, new Constant($val.getText())); }
|   val = TOK_FLOAT { $expr = L($ctx, new Constant(Float.parseFloat($val.getText()))); }
;

comparisonOperator returns [ComparisonOperator op]
:	OP_LEQ { $op = ComparisonOperator.LESS_OR_EQUAL; }
|	OP_GEQ { $op = ComparisonOperator.GREATER_OR_EQUAL; }
|	OP_LT { $op = ComparisonOperator.LESS_THAN; }
|	OP_GT { $op = ComparisonOperator.GREATER_THAN; }
;

equalityOperator returns [ComparisonOperator op]
:   OP_EQ { $op = ComparisonOperator.EQUAL; }
|   OP_NE { $op = ComparisonOperator.DIFFERENT; }
;

addSubOperator returns [ArithmeticOperator op]
:	PLUS { $op = ArithmeticOperator.ADD; }
|   MINUS { $op = ArithmeticOperator.SUB; }
;

mulDivModOperator returns [ArithmeticOperator op]
:   STAR { $op = ArithmeticOperator.MUL; }
|   SLASH { $op = ArithmeticOperator.DIV; }
|   PERCENT { $op = ArithmeticOperator.MOD; }
;

unaryOperator returns [UnaryOperator op]
:   PLUS { $op = UnaryOperator.PLUS; }
|   MINUS { $op = UnaryOperator.MINUS; }
|   BANG { $op = UnaryOperator.NOT; }
;

listComprehensionElements returns [Generator gen]
:   TOK_LET L_PAREN arguments R_PAREN listComprehensionExpr
	    { $gen = L($ctx, new LetGenerator($arguments.args, $listComprehensionExpr.gen)); }
//|   TOK_EACH listComprehensionExpr
//	    { $gen = L($ctx, new EachGenerator($listComprehensionExpr.gen)); }
|   TOK_FOR L_PAREN arguments R_PAREN listComprehensionExpr
	    { $gen = L($ctx, new ForRangeGenerator($arguments.args, $listComprehensionExpr.gen)); }
//|   TOK_FOR L_PAREN x1 = arguments SEMI x2 = expression SEMI x3 = arguments R_PAREN
//	listComprehensionExpr
//	    { $gen = L($ctx, new ForGenerator($x1.args, $x2.expr, $x3.args, $listComprehensionExpr.gen)); }
|   TOK_IF L_PAREN expression R_PAREN listComprehensionExpr
	    { $gen = L($ctx, new ConditionGenerator($expression.expr, $listComprehensionExpr.gen)); }
//|   TOK_IF L_PAREN expression R_PAREN ifC = listComprehensionExpr TOK_ELSE
//    elseC = listComprehensionExpr
//	    { $gen = L($ctx, new ConditionGenerator($expression.expr, $ifC.gen, $elseC.gen)); }
;

listComprehensionExpr returns [Generator gen]
:   listComprehensionElements
	    { $gen = $listComprehensionElements.gen; }
|   L_PAREN listComprehensionElements R_PAREN
        { $gen = $listComprehensionElements.gen; }
|   expression
	    { $gen = L($ctx, new ElementGenerator($expression.expr)); }
;

vectorOrGenerator returns [Expression value]
:	vectorExpr
   {
        $value = L($ctx, new Vector($vectorExpr.list));
   }
|  listComprehensionElements
  {
       $value =  L($ctx, new GeneratorExpression($listComprehensionElements.gen));
  }
;

vectorExpr returns [ArrayList<Expression> list]
:	   /* empty */
|   ne_vectorExpr
   {
        $list = $ne_vectorExpr.list;
   }
;

ne_vectorExpr returns [ArrayList<Expression> list]
:	expression
    {
        $list = new ArrayList<>();
        $list.add(L($ctx, $expression.expr));
    }
|   v = ne_vectorExpr COMMA+ expression
	{
		$list = $v.list;
		$list.add($expression.expr);
	}
;

parameters returns [ArrayList<Parameter> params]
:   /* empty */
| ne_parameters { $params = $ne_parameters.params; }
;

ne_parameters returns [ArrayList<Parameter> params]
:   parameter
        {
            $params = new ArrayList<>();
            $params.add($parameter.param);
        }
|   COMMA+ p = ne_parameters COMMA* { $params = $p.params; }
|   p = ne_parameters COMMA+ parameter
        {
            $params = $p.params;
            $params.add($parameter.param);
        }
;

parameter returns [Parameter param]
:   TOK_ID  { $param = L($ctx, new Parameter($TOK_ID.getText())); }
	(	EQUAL expression { $param.setDefaultValue($expression.expr); }
	)?
;

arguments returns [ArrayList<Argument> args]
:   /* empty */
| ne_arguments { $args = $ne_arguments.args; }
;

ne_arguments returns [ArrayList<Argument> args]
:|   argument
        {
            $args = new ArrayList<>();
            $args.add($argument.arg);
        }
|   COMMA+ a = ne_arguments COMMA* { $args = $a.args; }
|   a = ne_arguments COMMA+ argument
        {
            $args = $a.args;
            $args.add($argument.arg);
        }
;

argument returns [Argument arg]
:   expression { $arg = L($ctx, new Argument($expression.expr)); }
|   TOK_ID EQUAL expression { $arg = L($ctx, new Argument($TOK_ID.getText(), $expression.expr)); }
;