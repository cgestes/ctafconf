%{		/* -*- C++ -*- */		
/*
** @FILE-NAME@
** Login : <@USER-LOGIN@@@HOST@>
** Started on  @DATE-STAMP@ @USER-NAME@
** $@Id@$
*/

#include <iostream>

%}

%union {            
	/* define types */
}

%token	TOKEN_NAME "OUTPUTVALUE"

%token <val> NUM      /* define token NUM and its type */

%type <val> program /* specify the return types for non terminal*/

%pure_parser /* parser reentrant */

%start program

%%
program: /* Empty rules*/ {}
	;

%%



