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
:- load_files('./bin/cline_interface.pl',[silent(true)]).
:- include('./macros.pl').
% :- style_check(-atom).
:- run.

go :-

	grammar:ph(eng:e,"-y",B,C,D,E,F,G,H,I,J),
	!,
	rule_formatter:print_format_ph_rule(eng:e,rtf,
ph("-y",B,C,D,E,F,G,H,I,J)).					    
