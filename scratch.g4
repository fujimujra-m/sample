grammar scratch;

input: (nemonic (LF|WS)*)* EOF;

nemonic: instruction WS (operand WS?)*;

instruction: instructionname
    | instructionname suffix;

instructionname: TOKEN;
suffix: DOT_MODIFER SUFFIX;

operand: INDIRECT_MODIFIER? modifiedoperand
    | number
    | INDIRECT_MODIFIER? rawoperand;

rawoperand: TOKEN
    | rawlocaloperand;

rawlocaloperand: LOCAL_MODIFER rawoperand;

modifiedoperand: rawoperand INDEX_MODIFER (rawoperand|number)
    | wordbit_operand;


wordbit_operand: rawoperand DOT_MODIFER NUMBER;

number: NUMBER
    | HEXNUMBER;

LOCAL_MODIFER: '@';
INDIRECT_MODIFIER: '*';
DOT_MODIFER: DOT;
INDEX_MODIFER: COLLON;

NUMBER: [kK#]?SIGN?[0-9]*('.'[0-9]+('e'[0-9]+)?)?;
HEXNUMBER: [$H]?SIGN?[0-9a-fA-F]+;
WS: (' '|'\t')+;
LF: ('\r'|'\n');
SIGN: ([+-]);


SUFFIX: (S|L|U|D|D F|F);
TOKEN: ~[ @\n:\\.\\*]+;

//TOKENから * を除外すると、　CAL* だけ区別しないとだめになるなあ

//デバイスとラベルって、字句解析で区別するのがよい？ 　するとして、どうやって書くのがよいのかわからなかった。
//   TOKEN を、　細かく書いてわけてくのか。

//ワード中ビットが書けてない。

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