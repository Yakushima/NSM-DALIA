:- set_prolog_flag(double_quotes, codes).
:- use_module(library(pldoc)).
:- use_module(library(doc_latex)).
:- doc_collect(true).
:- doc_server(4000).
:- ['./bin/cline_interface.pl'].
:- doc_browser.

