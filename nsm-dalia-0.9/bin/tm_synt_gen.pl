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


:- set_prolog_flag(double_quotes,codes).

:- include('operators.pl').
:- include('dynamic.pl').




tm_gen_sentence(Lang,F) :-
	tm_synt_gen_sent(Lang,s:F,F1),
	tm_morph_gen_sent(Lang,F1,S),
	transcr(Lang,S1,S),
	write('Sentence: '), write(S1),nl.
	
tm_transl_sentence(L1,L2,S1,S2,R1) :-
	transcr(L1,S1,S1a),
	p_chart(L1,tagm,S1a,_Slot:Parse,R1),
	analyze_semantics(L1,Parse,Parse1),
	synt_semantics(L2,Parse1,Parse2),
	tm_morph_gen_sent(L2,s:Parse2,S2a),
	transcr(L2,S2,S2a).



gen_sentence(LF) :-
	current_lang(Lang),
	tm_synt_gen_sent(Lang,s:LF,Lex),
	tm_morph_gen_sent(Lang,Lex,[],PF),
	write('Sentence: '),put_string(PF),nl.


tm_synt_gen_sent(Lang,_Slot:F,S) :-
	syntagmeme(Lang,_Name,Synt,F,C),
	check_cond_list_aux(Lang,C,Synt,[]),
	synt_scan_syntagmeme(Lang,Synt,[],S).


synt_scan_syntagmeme(_Lang,[],Lex,Lex).
synt_scan_syntagmeme(Lang,[?_Slot:_Filler/e|Synt],Lex1,Lex) :-
	!,
	synt_scan_syntagmeme(Lang,Synt,Lex1,Lex).
synt_scan_syntagmeme(Lang,[_Slot:_Filler/e|Synt],Lex1,Lex) :-
	!,
	synt_scan_syntagmeme(Lang,Synt,Lex1,Lex).
synt_scan_syntagmeme(Lang,[_Slot:Filler/A|Synt],Lex1,Lex) :-
	syntagmeme(Lang,Filler,P,A,C),
	check_cond_list_aux(Lang,C,Synt,[]),
	!,
	synt_scan_syntagmeme(Lang,P,Lex1,Lex2),
	synt_scan_syntagmeme(Lang,Synt,Lex2,Lex).
synt_scan_syntagmeme(Lang,[?_Slot:Filler/A|Synt],Lex1,Lex) :-
	syntagmeme(Lang,Filler,P,A,C),
	check_cond_list_aux(Lang,C,Synt,[]),
	!,
	synt_scan_syntagmeme(Lang,P,Lex1,Lex2),
	synt_scan_syntagmeme(Lang,Synt,Lex2,Lex).
synt_scan_syntagmeme(Lang,[_Slot:Filler/Exp|Synt],Lex1,Lex) :-
	append(Lex1,[m(Filler,Exp)],Lex2),
	synt_scan_syntagmeme(Lang,Synt,Lex2,Lex).
synt_scan_syntagmeme(Lang,[?_Slot:Filler/Exp|Synt],Lex1,Lex) :-
	append(Lex1,[m(Filler,Exp)],Lex2),
	synt_scan_syntagmeme(Lang,Synt,Lex2,Lex).

