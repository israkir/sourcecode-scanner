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
 * 	1) scanner.l follows up the c naming conventions: 
 *	  http://www.cprogramming.com/tutorial/style_naming_conventions.html
 * Usage			: There are two options,
 *  1) a.out [input-filename]
 *  2) a.out // hit enter and use stdin
 ============================================================================
 */
  
	/* ----- DEFINITIONS PART ----- */
	/* ============================ */
	
	/* DEFINITIONS FOR TOKEN CODES */
	/* --------------------------- */
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
#define LBOX		91
#define RBOX		93
#define LCURLY		123
#define RURLY		125
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
IDENTIFIER		{LETTER}[{LETTER}{DIGIT}_]*

	/* integer: */
INTEGER			0|([1-9][0-9]*)

	/* string: */
STRING			\"[^\"\n]*\"

	/* comment type 1 corresponds to single line c style comments between slash-star */
COMMENT1		"/*"[^}\n]*"*/"

	/* comment type 2 corresponds to single line c style comments after two-slashes */
COMMENT2		"//"[^}\n]*"$


%%
	/* ----- RULES PART ----- */
	/* ====================== */

	/* RULES FOR OPERATORS AND PUNCTUATIONS */
	/* ------------------------------------ */
"+"			{ printf("%s\t%d\n", yytext, yytext[0]); }
"-" 			{ printf("%s\t%d\n", yytext, yytext[0]); }
"*"			{ printf("%s\t%d\n", yytext, yytext[0]); }
"/"			{ printf("%s\t%d\n", yytext, yytext[0]); }
"%"			{ printf("%s\t%d\n", yytext, yytext[0]); }
"&&"			{ printf("%s\t265\n", yytext); }
"||"			{ printf("%s\t266\n", yytext); }
"!"			{ printf("%s\t%d\n", yytext, yytext[0]); }
"<"			{ printf("%s\t%d\n", yytext, yytext[0]); }
">"			{ printf("%s\t%d\n", yytext, yytext[0]); }
"<="			{ printf("%s\t261\n", yytext); }
">="			{ printf("%s\t262\n", yytext); }
"=="			{ printf("%s\t263\n", yytext); }
"!="			{ printf("%s\t264\n", yytext); }
"&"			{ printf("%s\t%d\n", yytext, yytext[0]); }
"|"			{ printf("%s\t%d\n", yytext, yytext[0]); }
"^"			{ printf("%s\t%d\n", yytext, yytext[0]); }
"("			{ printf("%s\t%d\n", yytext, yytext[0]); }
")"			{ printf("%s\t%d\n", yytext, yytext[0]); }
"["			{ printf("%s\t%d\n", yytext, yytext[0]); }
"]"			{ printf("%s\t%d\n", yytext, yytext[0]); }
"{"			{ printf("%s\t%d\n", yytext, yytext[0]); }
"}"			{ printf("%s\t%d\n", yytext, yytext[0]); }
","			{ printf("%s\t%d\n", yytext, yytext[0]); }
";"			{ printf("%s\t%d\n", yytext, yytext[0]); }
"="			{ printf("%s\t%d\n", yytext, yytext[0]); }

	/* RULES FOR KEYWORDS */
	/* ------------------ */
"char"			{ printf("%s\t268\n", yytext); }
"int"			{ printf("%s\t269\n", yytext); }
"void"			{ printf("%s\t270\n", yytext); }
"if"			{ printf("%s\t271\n", yytext); }
"else"			{ printf("%s\t272\n", yytext); }
"while"			{ printf("%s\t273\n", yytext); }
"for" 			{ printf("%s\t274\n", yytext); }
"continue"		{ printf("%s\t275\n", yytext); }
"break"			{ printf("%s\t276\n", yytext); }
"return"		{ printf("%s\t277\n", yytext); }
	
	/* RULES FOR IDENTIFIIERS */
	/* ---------------------- */
{IDENTIFIER}		{ printf("258\t%s\n", yytext); }

	/* RULES FOR LITERALS */
	/* ------------------ */
{INTEGER}		{ printf("259\t%s\n", yytext); }
{STRING}		{ printf("260\t%s\n", yytext); }

	/* ignore any white space; i.e. no 'action'! */
{DELIMITER}+

	/* ignore any kind of comments; i.e. no 'action'! */
{COMMENT1}
{COMMENT2}
	

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
