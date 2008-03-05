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
#include "config-regexp.hh"

#ifdef ENABLE_NLS
#  include <libintl.h>
#endif


void buildGui(const ConfigParser::ConfigList &values, GuiFactory &gui_factory)
{
  ConfigParser::ConfigList::const_iterator it = values.begin();

  for (;it != values.end(); ++it)
  {
    const std::string &type = (*it)->type();
    const std::string &name = (*it)->name();
    const ConfigObject::ConfigKeys &keys = (*it)->keys();

    std::cout << "Config:" << name;
    std::cout << " Type:" << type << std::endl;
    if (type == "string")
    {
      const ConfigObject::ConfigKeys::const_iterator it = keys.find("default");
      std::string def;
      const ConfigObject::ConfigKeys::const_iterator it2 = keys.find("read");

      if (it != keys.end())
        def = (*it).second;

      if (it2 != keys.end())
        def = (*it2).second;

      gui_factory.add_string(name, def);

    }
    else if (type == "frame")
    {
      gui_factory.add_frame(name);

    }
    else if (type == "checkbox")
    {
      gui_factory.add_checkbox(name, 1);

    }
    else if (type == "singlechoice")
    {
      std::vector<std::string> values;
      const ConfigObject::ConfigKeys::const_iterator itd = keys.find("default");
      std::string def;

      if (itd != keys.end())
        def = (*itd).second;

      std::cout << "default: " << def << std::endl;

      ConfigObject::ConfigKeys::const_iterator it = keys.begin();
      for (;it != keys.end(); ++it)
      {
        if ((*it).first == "value")
          values.push_back((*it).second);
      }

      gui_factory.add_singlechoice(name, values, def);
    }
    else if (type == "multichoice")
    {
      std::vector<std::string> defaults;
      std::vector<std::string> values;

      ConfigObject::ConfigKeys::const_iterator it = keys.begin();
      for (;it != keys.end(); ++it)
      {
        if ((*it).first == "default")
          defaults.push_back((*it).second);
        else if ((*it).first == "value")
          values.push_back((*it).second);
      }
      gui_factory.add_multichoice(name, values, defaults);
    }
    else if (type == "button")
      gui_factory.add_button(name);


  }
}

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
  ConfigRegexp regexp;

  config.parse("er.tpl");

  regexp.process(config.values());

  buildGui(config.values(), gui_factory);

  dialog.show_all();
  kit.run(dialog);
  return 0;
}
