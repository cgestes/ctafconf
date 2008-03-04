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
#include "gui-factory.h"

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
Gtk::HBox *GuiFactory::add_box_with_label(const std::string &name)
{
  HBox *hbox = new HBox(1);
  Label *lbl = new Label(name);

  if (!m_current_page)
    return hbox;
  m_current_page->pack_start(*hbox, PACK_SHRINK, 3);
  lbl->set_alignment(Gtk::ALIGN_LEFT, Gtk::ALIGN_CENTER);
  hbox->pack_start(*lbl);
  return hbox;
}

void GuiFactory::add_frame(const string &name)
{
  //create a new vbox for the page
  m_current_page = new Gtk::VBox();

  //add the page to the notebook
  m_notebook.append_page(*m_current_page, name);
}

void GuiFactory::add_string(const std::string &name, const std::string &def)
{
  HBox *hbox;
  Entry *entry = new Entry();

  hbox = add_box_with_label(name);
  entry->set_text(def);
  hbox->pack_start(*entry);
}

void GuiFactory::add_checkbox(const std::string &name, bool def)
{
  HBox *hbox;
  CheckButton *btn = new CheckButton();

  btn->set_active(def);
  hbox = add_box_with_label(name);
  hbox->pack_start(*btn);
}


void GuiFactory::add_singlechoice(const std::string &name,
                                  const std::vector<std::string> &values,
                                  const std::string &def /*= ""*/)
{
  HBox *hbox;
  Label *lbl = new Label(name);
  ComboBoxText *combo = new ComboBoxText();
  StringVector::const_iterator it = values.begin();

  for (;it != values.end();++it) {
    combo->append_text(*it);
  }
  combo->set_active_text(def);

  hbox = add_box_with_label(name);
  hbox->pack_start(*combo);
}

/*
 * Gtk::TreeModel::iterator iter = m_Combo.get_active();
if(iter)
{
  Gtk::TreeModel::Row row = *iter;

  //Get the data for the selected row, using our knowledge
  //of the tree model:
  int id = row[m_Columns.m_col_id];
 *
 */
void GuiFactory::add_multichoice(const std::string &name,
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

  hbox = add_box_with_label(name);
  hbox->pack_start(*tv);
}

void GuiFactory::add_button(const std::string &name)
{
  HBox *hbox;
  Button *btn = new Button("Do IT");

  hbox = add_box_with_label(name);
  hbox->pack_start(*btn);
}
