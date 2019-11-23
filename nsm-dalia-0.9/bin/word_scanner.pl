/*
    This file is part of NSM-DALIA, an extensible parser and generator
    for NSM grammars.
       
    Copyright (C) 2009 Francesco Zamblera.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

*/

:- module(word_scanner,[
			get_word/3
		       ]).
:- set_prolog_flag(double_quotes,codes).

/** <module> 

Simple word scanner (reads from a string).
*/

%%	get_word(+Sentence:string,-Word:string,-Rest:string) is det
%
%	Unifies Word with the first word of Sentence, and Rest
%	with the original sentence minus the first word.
%	
get_word([32|Rest],[],Rest1) :- 
	!,
	skip_white(Rest,Rest1).
get_word([13|Rest],[],Rest1) :- 
	!,
	skip_white(Rest,Rest1).
get_word([10|Rest],[],Rest1) :- 
	!,
	skip_white(Rest,Rest1).
get_word([C|Rest],[],[Token|Rest1]) :- 
	single_token([C],Token),
	parsable(Token),
	!,
	skip_white(Rest,Rest1).
get_word([C|Rest],[],Rest1) :- 
	single_token([C],_Token),
	!,
	skip_white(Rest,Rest1).
get_word([W|String],[W|Word],Rest) :-
	get_word(String,Word,Rest).
get_word([],[],[]).

single_token(".",fullstop).
single_token(",",comma).
single_token(":",colon).
single_token(";",semi).


skip_white([10|Rest],Rest1) :-
	!,
	skip_white(Rest,Rest1).
skip_white([13|Rest],Rest1) :-
	!,
	skip_white(Rest,Rest1).
skip_white([8|Rest],Rest1) :-
	!,
	skip_white(Rest,Rest1).
skip_white([32|Rest],Rest1) :-
	!,
	skip_white(Rest,Rest1).
skip_white(R,R).

parsable(fullstop).
