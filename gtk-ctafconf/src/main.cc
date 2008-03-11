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


void buildGui(ConfigParser &config, GuiFactory &gui_factory)
{
  ConfigParser::iterator it = config.begin();

  for (;it != config.end(); ++it)
  {
    ConfigObject::ptr obj = (*it);
    const std::string &type = obj->type();
    const std::string &name = obj->name();

    if (type == "string")
    {
      std::string def;

      if (!obj->getStringQuoted("read", def))
        obj->getString("default", def);

      gui_factory.add_string(obj, name, def);

    }
    if (type == "int")
    {
      std::string def;

      if (!obj->getStringQuoted("read", def))
        obj->getString("default", def);

      gui_factory.add_int(obj, name, def);

    }
    else if (type == "frame")
    {
      gui_factory.add_frame(obj, name);

    }
    else if (type == "checkbox")
    {
      bool val = 0;
      if (!obj->getBool("read", val))
        obj->getBool("default", val);
      gui_factory.add_checkbox(obj, name, val);

    }
    else if (type == "singlechoice")
    {
      std::vector<std::string> values;
      std::string def;

      if (!obj->getStringQuoted("read", def))
        obj->getString("default", def);

      obj->getStrings("value", values);
      gui_factory.add_singlechoice(obj, name, values, def);
    }
    else if (type == "multichoice")
    {
      std::vector<std::string> defaults;
      std::vector<std::string> values;

      obj->getStrings("value", values);
      if (!obj->getStringsFormated("read", defaults))
        obj->getStrings("default", defaults);

      gui_factory.add_multichoice(obj, name, values, defaults);
    }
    else if (type == "button")
      gui_factory.add_button(obj, name);


  }
}

void on_button_apply_clicked(ConfigParser *config, ConfigRegexp *regexp)
{
  ConfigParser::iterator it = config->begin();


  for (;it != config->end(); ++it)
  {
    ConfigObject::ptr obj = (*it);
    const std::string &type = obj->type();
    const std::string &name = obj->name();

    if (type == "string")
    {
      Gtk::Entry *w = (Gtk::Entry *)obj->widget;

      if (!w)
        continue;
      obj->setStringQuoted("write", w->get_text(), "read");
    }
    if (type == "int")
    {
      Gtk::Entry *w = (Gtk::Entry *)obj->widget;

      if (!w)
        continue;
      obj->setStringQuoted("write", w->get_text(), "read");
    }
    else if (type == "frame")
    {
    }
    else if (type == "checkbox")
    {
      Gtk::CheckButton *w = (Gtk::CheckButton *)obj->widget;
      std::cout << name << ": " << w->get_active() << std::endl;
      obj->setBool("write", w->get_active());
    }
    else if (type == "singlechoice")
    {
      Gtk::ComboBoxText *w = (Gtk::ComboBoxText *)obj->widget;

      if (!w)
        continue;
      obj->setStringQuoted("write", w->get_active_text(), "read");
    }
    else if (type == "multichoice")
    {
      Gtk::TreeView *w = (Gtk::TreeView *)obj->widget;
      Gtk::TreeIter itt = w->get_model()->children().begin();
      std::vector<std::string> v;

      for (;itt != w->get_model()->children().end(); ++itt)
      {
        Gtk::TreeModel::Row row = *itt;
        Glib::ustring name = row[obj->columns->m_col_name];
        bool id = row[obj->columns->m_col_active];
        if (id)
          v.push_back(name);
      }
      obj->setStringsFormated("write", v);
    }
    else if (type == "button")
    {
    }
  }
  std::cout << "writing value" << std::endl;
  regexp->write(*config);
}

int
main (int argc, char *argv[])
{
  Gtk::Main kit(argc, argv);
  Gtk::Window dialog;
  Gtk::Notebook notebook;
  GuiFactory gui_factory(notebook);
  Gtk::VBox box;
  Gtk::Button button("Save");
  ConfigParser config;
  ConfigRegexp regexp;

  button.signal_clicked().connect(sigc::bind(sigc::ptr_fun(&on_button_apply_clicked), &config, &regexp));
  box.pack_start(notebook);
  box.pack_start(button, 0, 0);
  dialog.add(box);
  dialog.set_default_size(640, 480);

  /* parse template */
  config.parse(GTK_CTAFCONF_DATADIR"/template/main.tpl");

  /* read value from real file */
  regexp.read(config);

  /* construct the gui */
  buildGui(config, gui_factory);

  dialog.show_all();
  kit.run(dialog);
  return 0;
}
