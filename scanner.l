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
INTEGER		[0-9]{1,} /* One or more "one of the digits" */


%%
	/*----- RULES PART -----*/

	/* RULES FOR OPERATORS AND PUNCTUATIONS */
"+"			{ return PLUS; }
"-" 		{ return MINUS; }
"*"			{ return ASTERISK; }
"/"			{ return SLASH; }
"%"			{ return REMAINDER; }
"&&"		{ return LAND; }
"||"		{ return LOR; }
"!"			{ return LNOT; }
"<"			{ return LESSTHAN; }
">"			{ return GREATERTHAN; }
"<="		{ return LESSEQUAL; }
">="		{ return GREATEREQUAL; }
"=="		{ return EQUALTO; }
"!="		{ return NOTEQ; }
"&"			{ return BAND; }
"|"			{ return BOR; }
"^"			{ return BXOR; }
"("			{ return LPARA; }
")"			{ return RPARA; }
"["			{ return LSQUAREB; }
"]"			{ return RSQUAREB; }
"{"			{ return LCURLYB; }
"}"			{ return RCURLYB; }
","			{ return COMMA; }
";"			{ return SEMICOLON; }
"="			{ return ASSIGN; }

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



%%
	/*----- USER CODE PART -----*/
main() {
	printf("Input the source code and hit $\n");
	yylex();
}
