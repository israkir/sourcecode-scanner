/* ============================================================================
 * Program Name 	: scanner.l
 * Author			: Hakki Caner Kirmizi
 * Description		: A C source code scanner written with flex.
 * Environment		: Linux ubuntu 2.6.31-14-generic #48-Ubuntu SMP 
 *						Fri Oct 16 14:05:01 UTC 2009 x86_64 GNU/Linux
 * 					: gcc (Ubuntu 4.4.1-4ubuntu9) 4.4.1
 *					: flex 2.5.35
 * Notes			: 
 * 1) scanner.l follows up the c naming conventions: 
 *	  http://www.cprogramming.com/tutorial/style_naming_conventions.html
 * TODO: ignore comments
 * ============================================================================
 */


	/*----- DEFINITIONS PART -----*/
DIGIT		[0-9]
LETTER		[A-Za-z]
ID			{LETTER}({LETTER}|{DIGIT})*
NUMBER		{DIGIT}+(\.{DIGIT}+)?(E[+-]?{DIGIT}+)?
DELIMITER	[ \t\n]
STRING		{LETTER}[a-zA-Z0-9]*
INTEGER		[0-9]+


%%
	/*----- RULES PART -----*/

	/* RULES FOR OPERATORS AND PUNCTUATIONS */
"+"			{ printf("%s\t%d\t", yytext, atoi(yytext)); return PLUS; }
"-" 		{ printf("%s\t%d\t", yytext, atoi(yytext)); return MINUS; }
"*"			{ printf("%s\t%d\t", yytext, atoi(yytext)); return ASTERISK; }
"/"			{ printf("%s\t%d\t", yytext, atoi(yytext)); return SLASH; }
"%"			{ printf("%s\t%d\t", yytext, atoi(yytext)); return REMAINDER; }
"&&"		{ printf("%s\t265\t", yytext); return LAND; }
"||"		{ printf("%s\t266\t", yytext); return LOR; }
"!"			{ printf("%s\t%d\t", yytext, atoi(yytext)); return LNOT; }
"<"			{ printf("%s\t%d\t", yytext, atoi(yytext)); return LESSTHAN; }
">"			{ printf("%s\t%d\t", yytext, atoi(yytext)); return GREATERTHAN; }
"<="		{ printf("%s\t261\t", yytext); return LESSEQUAL; }
">="		{ printf("%s\t262\t", yytext); return GREATEREQUAL; }
"=="		{ printf("%s\t263\t", yytext); return EQUALTO; }
"!="		{ printf("%s\t264\t", yytext); return NOTEQ; }
"&"			{ printf("%s\t%d\t", yytext, atoi(yytext)); return BAND; }
"|"			{ printf("%s\t%d\t", yytext, atoi(yytext)); return BOR; }
"^"			{ printf("%s\t%d\t", yytext, atoi(yytext)); return BXOR; }
"("			{ printf("%s\t%d\t", yytext, atoi(yytext)); return LPARA; }
")"			{ printf("%s\t%d\t", yytext, atoi(yytext)); return RPARA; }
"["			{ printf("%s\t%d\t", yytext, atoi(yytext)); return LSQUAREB; }
"]"			{ printf("%s\t%d\t", yytext, atoi(yytext)); return RSQUAREB; }
"{"			{ printf("%s\t%d\t", yytext, atoi(yytext)); return LCURLYB; }
"}"			{ printf("%s\t%d\t", yytext, atoi(yytext)); return RCURLYB; }
","			{ printf("%s\t%d\t", yytext, atoi(yytext)); return COMMA; }
";"			{ printf("%s\t%d\t", yytext, atoi(yytext)); return SEMICOLON; }
"="			{ printf("%s\t%d\t", yytext, atoi(yytext)); return ASSIGN; }

	/* RULES FOR KEYWORDS */
"char"		{ return CHARSYM; }
"int"		{ return INTSYM; }
"void"		{ return VOIDSYM; }
"if"		{ return IFSYM; }
"else"		{ return ELSESYM; }
"while"		{ return WHILESYM; }
"for" 		{ return FORSYM; }
"continue"	{ return CONTINUESYM; }
"break"		{ return BREAKSYM; }
"return"	{ return RETURNSYM; }

	/* RULES FOR IDENTIFIIERS */


	/* RULES FOR LITERALS */
{DIGIT}+	{ yylval.num = atoi(yytext);
			  return NUMBER; }
{ID}		{ yyval = (int) install_id();
			  return ID; }
{NUMBER}	{ yyval = (int) install_number();
			  return NUMBER; }


%%
	/*----- USER CODE PART -----*/
main() {
	printf("Input the source code and hit $\n");
	yylex();
}

int install_id() {
	
}
