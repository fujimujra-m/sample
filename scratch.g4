grammar scratch;

input: (nemonic (LF|WS)*)* EOF;

nemonic: instruction WS (operand WS?)*;

instruction: instructionname
    | instructionname suffix;

instructionname: TOKEN;
suffix: '.' TOKEN;

operand: modifiedoperand
    | number
    | rawoperand ;

rawoperand: TOKEN;
modifiedoperand: rawoperand ':' rawoperand;
number: NUMBER | HEXNUMBER;

NUMBER: [kK#]?SIGN?[0-9]+'.'+[0-9]+;
HEXNUMBER: [H$]?SIGN?[0-9a-fA-F]+'.'+[0-9]+;
TOKEN: ~[ \n:\\.]+;
WS: (' '|'\t')+;
LF: ('\r'|'\n');
SIGN: ([+-]);


//デバイスとラベルって、字句解析で区別するのがよい？ 　するとして、どうやって書くのがよいのかわからなかった。
//   TOKEN を、　細かく書いてわけてくのか。
//fragment がよくわからない。　（ちゃんと調べてない。。）　　modifiedoperand で COLLON と書いたら動かず、 ':' と直接書いたら動いた。
//   なにか勘違いしている気がする。

fragment SUFFIX: '.';
fragment COLLON: ':';
fragment DOT: '.';

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