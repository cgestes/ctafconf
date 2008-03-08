/*
** gui-factory.cc
** Login : <ctaf@ctaf-laptop>
** Started on  Wed Feb 13 21:01:08 2008 GESTES Cedric
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

#include <gtkmm.h>
#include <string.h>
#include <iostream>
#include "gui-factory.hh"
#include "string-utils.hh"

using namespace std;
using namespace Gtk;

GuiFactory::GuiFactory(Gtk::Notebook &notebook)
  : m_notebook(notebook),
    m_current_page(0){
}

/*
 * add a hbox and a label
 * used by all other function
 */
Gtk::HBox *GuiFactory::add_box_with_label(ConfigObject &obj, const std::string &name)
{
  HBox *hbox = new HBox(1);
  std::string desc;

  if (!m_current_page)
    return hbox;
  obj.getString("desc", desc);
  desc = trim(desc);
  Label *lbl = new Label();
  if (desc == "")
  {
    lbl->set_text(name);
    m_current_page->pack_start(*hbox, PACK_SHRINK, 3);
  }
  else
  {
    lbl->set_text(name + ": \n" + desc);
    m_current_page->pack_start(*hbox, PACK_SHRINK, 5);
  }
  lbl->set_alignment(Gtk::ALIGN_LEFT, Gtk::ALIGN_CENTER);
  hbox->pack_start(*lbl);
  return hbox;
}

void GuiFactory::add_frame(ConfigObject &obj, const string &name)
{
  std::string desc;

  //create a new vbox for the page
  m_current_page = new Gtk::VBox();

  //add the page to the notebook
  m_notebook.append_page(*m_current_page, name);
  if (obj.getString("desc", desc))
  {
    Label *lbl = new Label(desc);
    lbl->set_alignment(Gtk::ALIGN_LEFT, Gtk::ALIGN_CENTER);
    m_current_page->pack_start(*lbl);
  }
}

void GuiFactory::add_string(ConfigObject &obj, const std::string &name, const std::string &def)
{
  HBox *hbox;
  Entry *entry = new Entry();

  hbox = add_box_with_label(obj, name);
  entry->set_text(def);
  hbox->pack_start(*entry);
  obj.widget = entry;

}

void GuiFactory::add_checkbox(ConfigObject &obj, const std::string &name, bool def)
{
  HBox *hbox;
  CheckButton *btn = new CheckButton();

  btn->set_active(def);
  hbox = add_box_with_label(obj, name);
  hbox->pack_start(*btn);
  obj.widget = btn;
}


void GuiFactory::add_singlechoice(ConfigObject &obj,
                                  const std::string &name,
                                  const std::vector<std::string> &values,
                                  const std::string &def /*= ""*/)
{
  HBox *hbox;
  ComboBoxText *combo = new ComboBoxText();
  StringVector::const_iterator it = values.begin();

  for (;it != values.end();++it) {
    combo->append_text(*it);
  }
  combo->set_active_text(def);

  hbox = add_box_with_label(obj, name);
  hbox->pack_start(*combo);
  obj.widget = combo;
}

void GuiFactory::add_multichoice(ConfigObject &obj,
                                 const std::string &name,
                                 const std::vector<std::string> &values,
                                 const std::vector<std::string> &defaults)
{
  HBox *hbox;
  TreeView *tv = new TreeView();
  ComboModelColumns *m_Columns = new ComboModelColumns();
  Glib::RefPtr<Gtk::ListStore> m_refTreeModel;
  Gtk::TreeModel::Row row;
  StringVector::const_iterator it = values.begin();
  StringVector::const_iterator p;

  m_refTreeModel = Gtk::ListStore::create(*m_Columns);
  tv->set_model(m_refTreeModel);

  tv->append_column_editable("", m_Columns->m_col_active);
  tv->append_column("Name", m_Columns->m_col_name);

  for (;it != values.end();++it) {
    row = *(m_refTreeModel->append());
    row[m_Columns->m_col_name] = *it;

    p = find(defaults.begin(), defaults.end(), *it);
    row[m_Columns->m_col_active] = p != defaults.end();
  }

  hbox = add_box_with_label(obj, name);
  hbox->pack_start(*tv);
  obj.widget = tv;
  obj.columns = m_Columns;
}

void GuiFactory::add_button(ConfigObject &obj, const std::string &name)
{
  HBox *hbox;
  Button *btn = new Button("Do IT");

  hbox = add_box_with_label(obj, name);
  hbox->pack_start(*btn);
  obj.widget = btn;
}
