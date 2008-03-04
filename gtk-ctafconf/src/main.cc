/* -*- Mode: C; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*- */
/*
 * main.cc
 * Copyright (C) GESTES Cedric 2008 <ctaf42@gmail.com>
 *
 * main.cc is free software.
 *
 * You may redistribute it and/or modify it under the terms of the
 * GNU General Public License, as published by the Free Software
 * Foundation; either version 2 of the License, or (at your option)
 * any later version.
 *
 * main.cc is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with main.cc.  If not, write to:
 * 	The Free Software Foundation, Inc.,
 * 	51 Franklin Street, Fifth Floor
 * 	Boston, MA  02110-1301, USA.
 */

#include <gtkmm.h>
#include <iostream>

#include "gui-factory.h"
#include "config-parser.h"

#ifdef ENABLE_NLS
#  include <libintl.h>
#endif


int
main (int argc, char *argv[])
{
	Gtk::Main kit(argc, argv);
	Gtk::Window dialog;
	Gtk::Notebook notebook;
	GuiFactory gui_factory(notebook);
/* 	ConfigParserCtafconf cp_ctafconf(gui_factory); */
/* 	ConfigParserEmacs cp_emacs(gui_factory); */

	dialog.add(notebook);
	dialog.set_default_size(640, 480);

	ConfigParser config;

	config.parse("er.tpl");
/* 	cp_ctafconf.load("user-profile.ct-tpl"); */
/* 	cp_emacs.load("emacs.ct-tpl"); */

	gui_factory.add_frame("bob");
	gui_factory.add_string("str1", "blabla");
	gui_factory.add_string("str2");

	std::vector<std::string> strings;
	strings.push_back("tata");
	strings.push_back("toto");
	strings.push_back("titi");
	gui_factory.add_singlechoice("combotext", strings, "titi");

	std::vector<std::string> strings2;
	strings2.push_back("tata");
	strings2.push_back("titi");

	gui_factory.add_frame("bob2");

	gui_factory.add_multichoice("tree", strings, strings2);
	gui_factory.add_checkbox("str2", 1);

	dialog.show_all();
	kit.run(dialog);
	return 0;
}
