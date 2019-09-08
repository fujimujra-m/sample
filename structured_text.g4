grammar structured_text;

input: statements EOF;

statements
    : (statement SEMI_COLON|SINGLE_LINE_COMMENT)+
    ;

statement
    : IDENTIFIER ASSIGN statement                   #statement_assign
    | REPEAT statements UNTIL expr END_REPEAT       #statement_repeat
    | CASE expr OF case_statement+ END_CASE         #statement_case
    | EXIT                                          #statement_exit     //repeat の中だけで使えるようにすべきか。
    | RETURN                                        #statement_return
    | expr                                          #statement_expr
    ;

case_statement
    : conds+=case_condition (COMMA conds+=case_condition)* COLON statements?                  #case_statements_condition
    | ELSE statements?                              #case_statements_else
    ;

case_condition
    : IDENTIFIER
    | IDENTIFIER RANGE IDENTIFIER
    ;

expr
    : num                                           #expr_number
    | text                                          #expr_text
    | parenthesis_expr                              #expr_none
    | op=(NOT|MINUS) rhs=expr                       #expr_sign
    | <assoc=right> lhs=expr POW rhs=expr           #expr_power
    | lhs=expr op=(ASTERISK|SLASH|MOD) rhs=expr     #expr_muldiv
    | lhs=expr rhs=parenthesis_expr                 #expr_mul
    | lhs=expr op=(PLUS|MINUS) rhs=expr             #expr_addsub
    | lhs=expr op=(LT|LE|GT|GE) rhs=expr            #expr_comp
    | lhs=expr op=(EQ|NEQ) rhs=expr                 #expr_eq_neq
    | lhs=expr op=AND rhs=expr                      #expr_boolean_add
    | lhs=expr op=EXOR rhs=expr                     #expr_boolean_exor
    | lhs=expr op=OR rhs=expr                       #expr_boolean_or
    | funcname=IDENTIFIER OPEN_PAREN (args+=func_expr (COMMA args+=func_expr)*)? CLOSE_PAREN #expr_funccall
    | IDENTIFIER                                    #expr_identifier
    ;

func_expr
    : expr                                  #arg_expr
    | IDENTIFIER (ASSIGN| OUTREF) expr      #arg_assign
    ;

parenthesis_expr
    : OPEN_PAREN expr CLOSE_PAREN;

num
    : (TYPE_SPEC '#')? (BIN_NUMBER|OCT_NUMBER|HEX_NUMBER|NUMBER)
    ;


text
    : (TYPE_SPEC '#')? MBCS_STR
    | (TYPE_SPEC '#')? WSTR_STR
    ;

PLUS : '+';
MINUS : '-';
ASTERISK : '*';
SLASH : '/';
POW: '**';
LT: '<';
GT: '>';
LE: '<=';
GE: '>=';
EQ: '=';
NEQ: '<>';
ASSIGN: ':=';
OUTREF: '=>';
RANGE: '..';
COMMA: ',';
OPEN_PAREN : '(';
CLOSE_PAREN : ')';
COLON: ':';
SEMI_COLON: ';';
SINGULE_QUOT: '\'';
DOUBLE_QUOT: '"';
MOD: M O D;
NOT: N O T;
AND: (A N D|'&');
EXOR: X O R;
OR: O R;

CASE: C A S E;
OF: O F;
ELSE: E L S E;
END_CASE: E N D '_' C A S E;
REPEAT: R E P E A T;
UNTIL: U N T I L;
END_REPEAT: E N D '_' R E P E A T;
RETURN: R E T U R N;
EXIT: E X I T;

TYPE_SPEC: (INT|UINT|UDINT|REAL|LREAL|STRING|WSTRING);
BIN_NUMBER: '2' '#' [01_]+;
OCT_NUMBER: '8' '#' [0-7]+;
HEX_NUMBER: '1' '6' '#' [0-9a-fA-F]+;
NUMBER: (PLUS|MINUS)?[0-9]*'.'?[0-9]*('e'[0-9]+)?;

fragment ID_START: [A-Za-z_];
fragment ID_CONTINUE: ID_START | [0-9];
IDENTIFIER: ID_START ID_CONTINUE*;

MBCS_STR: '\''(~[']|'\\''\'')*'\'';
WSTR_STR: '"'(~[']|'\\''\'')*'"';


WS: [ \t]+ -> skip;
EOL: ('\r'? '\n' | '\r') -> skip;
SINGLE_LINE_COMMENT: '//' ~[\r\n]*;

fragment INT: I N T;
fragment DINT: D INT;
fragment UINT: U INT;
fragment UDINT: U DINT;
fragment REAL: R E A L;
fragment LREAL: L REAL;
fragment STRING: S T R I N G;
fragment WSTRING: W STRING;

fragment A: [Aa];
fragment B: [Bb];
fragment C: [Cc];
fragment D: [Dd];
fragment E: [Ee];
fragment F: [Ff];
fragment G: [Gg];
fragment H: [Hh];
fragment I: [Ii];
fragment J: [Jj];
fragment K: [Kk];
fragment L: [Ll];
fragment M: [Mm];
fragment N: [Nn];
fragment O: [Oo];
fragment P: [Pp];
fragment Q: [Qq];
fragment R: [Rr];
fragment S: [Ss];
fragment T: [Tt];
fragment U: [Uu];
fragment V: [Vv];
fragment W: [Ww];
fragment X: [Xx];
fragment Y: [Yy];
fragment Z: [Zz];