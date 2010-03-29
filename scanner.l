/* ============================================================================
 * Program Name 	: scanner.l
 * Author			: Hakki Caner Kirmizi
 * Description		: A C source code scanner written with flex.
 * Environment		: Linux ubuntu 2.6.31-14-generic #48-Ubuntu SMP 
 *						Fri Oct 16 14:05:01 UTC 2009 x86_64 GNU/Linux
 * 					: gcc (Ubuntu 4.4.1-4ubuntu9) 4.4.1
 *					: flex 2.5.35
 * Notes			: 
 * 	1) scanner.l follows up the c naming conventions: 
 *	  http://www.cprogramming.com/tutorial/style_naming_conventions.html
 * Usage			: There are two options,
 *  1) a.out [input-filename]
 *  2) a.out // hit enter and use stdin
 * ============================================================================
 */
 
 
	/* ----- DEFINITIONS PART ----- */
	/* ============================ */
	
	/* digit: any number from 0 to 9 */
DIGIT			[0-9]

	/* letter: any uppercase or lowercase letter */
LETTER			[A-Za-z]

	/* delimiter: any occurence of 'space', 'tab' or 'newline' */
DELIMITER		[ \t\n]

	/* identifier: starting with a letter; following by any occurence of letter, digit or underscore */
IDENTIFIER		{LETTER}({LETTER}|{DIGIT}|"_")*

	/* integer: */
INTEGER			{DIGIT}+(\.{DIGIT}+)?(E[+-]?{DIGIT}+)?

	/* string: */


	/* comment type 1 corresponds to single line c style comments between slash-star */
COMMENT1		"/*"[^}\n]*"*/"

	/* comment type 2 corresponds to single line c style comments after two-slashes */
COMMENT2		"//"[^}\n]*"\n"


%%
	/* ----- RULES PART ----- */
	/* ====================== */

	/* RULES FOR OPERATORS AND PUNCTUATIONS */
	/* ------------------------------------ */
"+"				{ printf("%s\t%d\n", yytext, yytext[0]); }
"-" 			{ printf("%s\t%d\n", yytext, yytext[0]); }
"*"				{ printf("%s\t%d\n", yytext, yytext[0]); }
"/"				{ printf("%s\t%d\n", yytext, yytext[0]); }
"%"				{ printf("%s\t%d\n", yytext, yytext[0]); }
"&&"			{ printf("%s\t265\n", yytext); }
"||"			{ printf("%s\t266\n", yytext); }
"!"				{ printf("%s\t%d\n", yytext, yytext[0]); }
"<"				{ printf("%s\t%d\n", yytext, yytext[0]); }
">"				{ printf("%s\t%d\n", yytext, yytext[0]); }
"<="			{ printf("%s\t261\n", yytext); }
">="			{ printf("%s\t262\n", yytext); }
"=="			{ printf("%s\t263\n", yytext); }
"!="			{ printf("%s\t264\n", yytext); }
"&"				{ printf("%s\t%d\n", yytext, yytext[0]); }
"|"				{ printf("%s\t%d\n", yytext, yytext[0]); }
"^"				{ printf("%s\t%d\n", yytext, yytext[0]); }
"("				{ printf("%s\t%d\n", yytext, yytext[0]); }
")"				{ printf("%s\t%d\n", yytext, yytext[0]); }
"["				{ printf("%s\t%d\n", yytext, yytext[0]); }
"]"				{ printf("%s\t%d\n", yytext, yytext[0]); }
"{"				{ printf("%s\t%d\n", yytext, yytext[0]); }
"}"				{ printf("%s\t%d\n", yytext, yytext[0]); }
","				{ printf("%s\t%d\n", yytext, yytext[0]); }
";"				{ printf("%s\t%d\n", yytext, yytext[0]); }
"="				{ printf("%s\t%d\n", yytext, yytext[0]); }

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
{IDENTIFIER}	{ printf("258\t%s\n", yytext); }

	/* RULES FOR LITERALS */
	/* ------------------ */
{INTEGER}		{ printf("259\t%s\n", yytext); }


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