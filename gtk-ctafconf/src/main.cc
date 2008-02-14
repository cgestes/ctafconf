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

#include <libglademm/xml.h>
#include <gtkmm.h>
#include <iostream>

#include "gui-factory.h"

#ifdef ENABLE_NLS
#  include <libintl.h>
#endif


/* For testing propose use the local (not installed) glade file */
/* #define GLADE_FILE PACKAGE_DATA_DIR"/gtk-ctafconf/glade/gtk-ctafconf.glade" */
#define GLADE_FILE "gtk-ctafconf.glade"

int
main (int argc, char *argv[])
{
	Gtk::Main kit(argc, argv);
	Gtk::Window dialog;
	Gtk::Notebook notebook;
	GuiFactory gui_factory(notebook);
	ConfigParserCtafconf cp_ctafconf(gui_factory);
	ConfigParserEmacs cp_emacs(gui_factory);

	dialog.add(notebook);

	cp_ctafconf.load("user-profile.ct-tpl");
	cp_emacs.load("emacs.ct-tpl");

	gui_factory.add_frame("bob");
	gui_factory.add_string("str1", "blabla");
	gui_factory.add_string("str2");
	std::vector<std::string> strings;
	strings.push_back("tata");
	strings.push_back("toto");
	strings.push_back("titi");
	gui_factory.add_singlechoice("combotext", strings, "tata");
	gui_factory.add_frame("bob2");

	dialog.show_all();
	kit.run(dialog);
	return 0;
}
