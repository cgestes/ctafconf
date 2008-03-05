/*
** gui-factory.h
** Login : <ctaf@ctaf-laptop>
** Started on  Wed Feb 13 21:01:20 2008 GESTES Cedric
** $Id$
**
** Author(s):
**  - GESTES Cedric <ctaf42@gmail.com>
**
** Copyright (C) 2008 GESTES Cedric
** This program is free software; you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation; either version 3 of the License, or
** (at your option) any later version.
**
** This program is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with this program; if not, write to the Free Software
** Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
*/

#ifndef   	GUI_FACTORY_HH_
# define   	GUI_FACTORY_HH_

#include <gtkmm.h>
#include <gtkmm/notebook.h>
#include <string.h>
#include <vector>

//Tree model columns:
class ComboModelColumns : public Gtk::TreeModel::ColumnRecord {
 public:
  ComboModelColumns() {
    add(m_col_name);
    add(m_col_active);
  }
  Gtk::TreeModelColumn<Glib::ustring> m_col_name;
  Gtk::TreeModelColumn<bool> m_col_active;
};


class GuiFactory
{
 public:
  typedef std::vector<std::string> StringVector;

  GuiFactory(Gtk::Notebook &notebook);

  void add_frame(const std::string &name);

  void add_string(const std::string &name,
                  const std::string &def = "");

  void add_checkbox(const std::string &name, bool def);

  void add_int(const std::string &name);

  void add_singlechoice(const std::string &name,
                        const StringVector &values,
                        const std::string &def = "");

  void add_multichoice(const std::string &name,
                       const StringVector &values,
                       const StringVector &defaults);

  void add_button(const std::string &name);

 protected:
  Gtk::HBox *add_box_with_label(const std::string &name);

 protected:
  Gtk::Notebook &m_notebook;
  Gtk::Box *m_current_page;
};

#endif 	    /* !GUI_FACTORY_HH_ */
