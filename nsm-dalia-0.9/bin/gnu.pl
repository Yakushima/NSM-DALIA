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

:- module(gnu,[
	       gpl/5,
	       gnu_no_warranty/1,
	       gnu_conditions/1
	      ]).
:- set_prolog_flag(double_quotes,codes).

:- use_module(utils).


/** <module> GNU Licenses 

*/

%%	gpl(+Program,+Version,+Year,+Author,+S) is det
%
%	This procedure is invoked when the program is started.
%	
%	It prints the GNU GPL "banner" before entering the main loop.
%	
%	When NSM-DALIA is started, it looks like this:
%	
%	==
%	** Welcome to DALIA (version 1.0). Copyright (C) 2009 Francesco Zamblera.
%	** This program comes with ABSOLUTELY NO WARRANTY; for details type `w'. 
%	** This is free software, and you are welcome to redistribute it under 
%	certain conditions; type `c' for details.
%	
%	DALIA>
%	==
%	
gpl(Program,Version,Year,Author,S) :-
    append_list(S,["** Welcome to ",Program," (version ",Version,
		   "). Copyright (C) ",
		   Year, " ", Author, ".\n\c
		    ** This program comes with ABSOLUTELY \c
		   NO WARRANTY; for details type `w'. \n\c
		    ** This is free software, and you are welcome to \c
		   redistribute it under certain conditions; \n\c
		   type `c' for details."]).

%%	gnu_no_warranty(-Text) is det
%
%	Unifies Text with the GNU GPL no-warranty disclaimer.
%	
gnu_no_warranty("THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES PROVIDE THE PROGRAM *AS IS* WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU. SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.\n").

%%	gnu_conditions(-Text) is det
%
%	Unifies Text with a sentence pointing to the condition
%	section of the GNU GPL.
%	
gnu_conditions("See expecially section 4 to 7 of the GNU GPL (file COPYING.TXT).\n").


