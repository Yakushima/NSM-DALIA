:- set_prolog_flag(double_quotes,codes).
:- use_module(library(pldoc)).
:- use_module(library(doc_latex)).
:- doc_collect(true).
:- doc_server(4000).
:- ['cline_interface.pl'].
:- doc_browser.

makebook :-
	doc_latex('manual.txt', 'manual.tex',[]).

