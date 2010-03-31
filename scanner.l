/* 
 ============================================================================
 * Program Name 		: scanner.l
 * Author			: Hakki Caner Kirmizi
 * Description			: A C source code scanner written with flex.
 * Environment			: Windows-7 Entreprise
 * Editor			: vim 7.2 for WIN 
 * Integration Tests		: linux2.csie.ntu.edu.tw
 * Flex				:
 * Compiler			:
 * Version Control		: TortoiseSVN 1.6.7, Build 18415 - 32 Bit
 * Project Hosting		: http://code.google.com/p/c-source-scanner/
 * Notes			: 
 *  1) scanner.l follows up the c naming conventions: 
 *	http://www.cprogramming.com/tutorial/style_naming_conventions.html
 * Usage			: There are two options,
 *  1) a.out [input-filename]
 *  2) a.out // hit enter and use stdin
 ============================================================================
 */
  
	/* ----- DEFINITIONS PART ----- */
	/* ============================ */
	
	/* DEFINITIONS FOR TOKEN CODES */
	/* --------------------------- */
	
	/* ' The literal block %{ ... %} ' in this part is copied to verbatim to the generated 
	    C source file near the beginning, before the beginning of yylex() */
%{
#define PLUS		43
#define MINUS		45
#define MULT		42
#define DIV		47
#define PERCENT		37
#define LAND		265
#define LOR		266
#define LNOT		33
#define LESSTHAN	60
#define GREATERTHAN 	62
#define LTEQUAL		261		
#define GTEQUAL		262
#define EQUAL		263		
#define NOTEQUAL	264
#define BITAND		38
#define BITOR		124
#define BITXOR		94
#define LPARA		40
#define RPARA		41
#define LBRACKET	91
#define RBRACKET	93
#define LCURLY		123
#define RCURLY		125
#define COMMA		44
#define SEMICOLON	59
#define ASSIGN		61
#define CHARSYM		268
#define INTSYM		269
#define VOIDSYM		270
#define IFSYM		271
#define ELSESYM		272
#define WHILESYM	273
#define FORSYM		274
#define CONTINUESYM	275
#define BREAKSYM	276
#define RETURNSYM	277
#define IDENTIFIER	258
#define INTEGER		259
#define STRING		260

const char* dec_to_hex(const char* number) {
	char *temp;
	char *buffer;
	int len, i;
	
	temp = malloc(sizeof(char) * 11);
	buffer = malloc(sizeof(char) * 8);

	sprintf(buffer, "%x", atoi(number));
	sprintf(temp, "0x");
	len = strlen(buffer);
	
	for (i=2; i<10-len; i++)
		temp[i] = '0';
	
	strncat(temp, buffer, len);
	return temp;
	free(buffer);
	free(temp);
}

%}

	/* DEFINITIONS FOR FINITE AUTOMATA */
	/* ------------------------------- */
	
	/* digit: any number from 0 to 9 */
DIGIT			[0-9]

	/* letter: any uppercase or lowercase letter */
LETTER			[A-Za-z]

	/* delimiter: any occurence of 'space', 'tab' or 'newline' */
DELIMITER		[ \t\n]

	/* identifier: starting with a letter; following by any occurence of letter, digit or underscore */
IDENTIFIER		{LETTER}({LETTER}|{DIGIT}|"_")*

	/* integer: 0 or more occurence of consecutive digits */
INTEGER			0|([1-9][0-9]*)

	/* string: anything between double quote; just considers \" and \\ characters */
STRING			\"[^\"\n]*\"

	/* comment type 1 corresponds to single line c style comments between slash-star */
COMMENT1		"/*"[^}\n]*"*/"

	/* comment type 2 corresponds to single line c style comments after two-slashes */
COMMENT2		"//"[^}\n]*"\n"

	/* comment type 3 corresponds to there be text before or following comment */
COMMENT3		.+"/*".*"*/".*\n

	/* comment type 4 corresponds to there be text following comment */
COMMENT4		.*"/*".*"*/".+\n


%%
	/* ----- RULES PART ----- */
	/* ====================== */

	/* RULES FOR OPERATORS AND PUNCTUATIONS */
	/* ------------------------------------ */
"+"			{ printf("%d\n", PLUS); }
"-" 			{ printf("%d\n", MINUS); }
"*"			{ printf("%d\n", MULT); }
"/"			{ printf("%d\n", DIV); }
"%"			{ printf("%d\n", PERCENT); }
"&&"			{ printf("%d\n", LAND); }
"||"			{ printf("%d\n", LOR); }
"!"			{ printf("%d\n", LNOT); }
"<"			{ printf("%d\n", LESSTHAN); }
">"			{ printf("%d\n", GREATERTHAN); }
"<="			{ printf("%d\n", LTEQUAL); }
">="			{ printf("%d\n", GTEQUAL); }
"=="			{ printf("%d\n", EQUAL); }
"!="			{ printf("%d\n", NOTEQUAL); }
"&"			{ printf("%d\n", BITAND); }
"|"			{ printf("%d\n", BITOR); }
"^"			{ printf("%d\n", BITXOR); }
"("			{ printf("%d\n", LPARA); }
")"			{ printf("%d\n", RPARA); }
"["			{ printf("%d\n", LBRACKET); }
"]"			{ printf("%d\n", RBRACKET); }
"{"			{ printf("%d\n", LCURLY); }
"}"			{ printf("%d\n", RCURLY); }
","			{ printf("%d\n", COMMA); }
";"			{ printf("%d\n", SEMICOLON); }
"="			{ printf("%d\n", ASSIGN); }

	/* RULES FOR KEYWORDS */
	/* ------------------ */
"char"			{ printf("%d\n", CHARSYM); }
"int"			{ printf("%d\n", INTSYM); }
"void"			{ printf("%d\n", VOIDSYM); }
"if"			{ printf("%d\n", IFSYM); }
"else"			{ printf("%d\n", ELSESYM); }
"while"			{ printf("%d\n", WHILESYM); }
"for" 			{ printf("%d\n", FORSYM); }
"continue"		{ printf("%d\n", CONTINUESYM); }
"break"			{ printf("%d\n", BREAKSYM); }
"return"		{ printf("%d\n", RETURNSYM); }
	
	/* RULES FOR IDENTIFIIERS */
	/* ---------------------- */
{IDENTIFIER}		{ printf("%d\t%s\n", IDENTIFIER, yytext); }

	/* RULES FOR LITERALS */
	/* ------------------ */
{INTEGER}		{ printf("%d\t%s\n", INTEGER, dec_to_hex(yytext)); }
{STRING}		{ printf("%d\t%s\n", STRING, yytext); }

	/* ignore any white space; i.e. no 'action'! */
{DELIMITER}+

	/* ignore any kind of comments; i.e. no 'action'! */
{COMMENT1}
{COMMENT2}
{COMMENT3}
{COMMENT4}
	

%%
	/* ----- USER CODE PART ----- */
	/* ========================== */
main(argc, argv)
int argc;
char **argv;
    {
    ++argv, --argc;
    if ( argc > 0 )
		yyin = fopen(argv[0], "r");
    else
		yyin = stdin;
	yylex();
    }
