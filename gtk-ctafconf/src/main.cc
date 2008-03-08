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
#include <config.h>
#include "gui-factory.hh"
#include "config-parser.hh"
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

//     std::cout << "Config:" << name;
//     std::cout << " Type:" << type << std::endl;
    if (type == "string")
    {
      const ConfigObject::ConfigKeys::const_iterator it3 = keys.find("default");
      std::string def;
      const ConfigObject::ConfigKeys::const_iterator it2 = keys.find("read");

      if (it3 != keys.end())
        def = (*it3).second;

      if (it2 != keys.end())
        def = (*it2).second;

      gui_factory.add_string(*(*it), name, def);

    }
    else if (type == "frame")
    {
      gui_factory.add_frame(*(*it), name);

    }
    else if (type == "checkbox")
    {
      gui_factory.add_checkbox(*(*it), name, 1);

    }
    else if (type == "singlechoice")
    {
      std::vector<std::string> values;
      const ConfigObject::ConfigKeys::const_iterator itd = keys.find("default");
      std::string def;

      if (itd != keys.end())
        def = (*itd).second;

//       std::cout << "default: " << def << std::endl;

      ConfigObject::ConfigKeys::const_iterator it3 = keys.begin();
      for (;it3 != keys.end(); ++it3)
      {
        if ((*it3).first == "value")
          values.push_back((*it3).second);
      }

      gui_factory.add_singlechoice(*(*it), name, values, def);
    }
    else if (type == "multichoice")
    {
      std::vector<std::string> defaults;
      std::vector<std::string> values;

      ConfigObject::ConfigKeys::const_iterator it3 = keys.begin();
      for (;it3 != keys.end(); ++it3)
      {
        if ((*it3).first == "default")
          defaults.push_back((*it3).second);
        else if ((*it3).first == "value")
          values.push_back((*it3).second);
      }
      gui_factory.add_multichoice(*(*it), name, values, defaults);
    }
    else if (type == "button")
      gui_factory.add_button(*(*it), name);


  }
}

void on_button_clicked(ConfigParser *config, ConfigRegexp *regexp)
{
  std::cout << "Hello World" << std::endl;
  ConfigParser::ConfigList::const_iterator it = config->values().begin();

  for (;it != config->values().end(); ++it)
  {
    const std::string &type = (*it)->type();
    const std::string &name = (*it)->name();
    ConfigObject::ConfigKeys &keys = (*it)->keys();

    if (type == "string")
    {
      Gtk::Entry *w = (Gtk::Entry *)(*it)->widget;
      std::cout << name << ": " << w->get_text() << std::endl;
      keys.insert(std::make_pair("write", w->get_text()));

    }
    else if (type == "frame")
    {
    }
    else if (type == "checkbox")
    {
      Gtk::CheckButton *w = (Gtk::CheckButton *)(*it)->widget;
      std::cout << name << ": " << w->get_active() << std::endl;
    }
    else if (type == "singlechoice")
    {
      Gtk::ComboBoxText *w = (Gtk::ComboBoxText *)(*it)->widget;
      const std::string val = w->get_active_text();
      std::cout << "combo : " << val << std::endl;
      keys.insert(std::make_pair("write", val));
    }
    else if (type == "multichoice")
    {
      Gtk::TreeView *w = (Gtk::TreeView *)(*it)->widget;
      Gtk::TreeIter itt = w->get_model()->children().begin();

      for (;itt != w->get_model()->children().end(); ++itt)
      {
        Gtk::TreeModel::Row row = *itt;
        Glib::ustring name = row[(*it)->columns->m_col_name];
        bool id = row[(*it)->columns->m_col_active];
        std::cout << "combo : " << name << ": " << id << std::endl;
      }
    }
    else if (type == "button")
    {
    }
  }
  std::cout << "writing value" << std::endl;
  regexp->write(config->values());
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
  Gtk::VBox box;
  Gtk::Button button("Save");
  ConfigParser config;
  ConfigRegexp regexp;

  button.signal_clicked().connect(sigc::bind(sigc::ptr_fun(&on_button_clicked), &config, &regexp));
  box.pack_start(notebook);
  box.pack_start(button);
  dialog.add(box);
  dialog.set_default_size(640, 480);


  config.parse(GTK_CTAFCONF_DATADIR"/template/main.tpl");

  regexp.process(config.values());

  buildGui(config.values(), gui_factory);

  std::cout << "writing value" << std::endl;
  regexp.write(config.values());
  dialog.show_all();
  kit.run(dialog);
  return 0;
}
