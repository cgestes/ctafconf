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


void GuiFactory::add_frame(const string &name)
{
  std::cerr << "adding a page: " << name << endl;

  //create a new vbox for the page
  m_current_page = new Gtk::VBox();

  //add the page to the notebook
  m_notebook.append_page(*m_current_page, name);
}

void GuiFactory::add_string(const std::string &name, const std::string &def)
{
  HBox *hbox = new HBox();
  Entry *entry = new Entry();
  Label *lbl = new Label(name);

  std::cerr << "adding a string: " << name << endl;

  if (!m_current_page)
    return;
  m_current_page->pack_start(*hbox);
  hbox->pack_start(*lbl);

  entry->set_text(def);
  hbox->pack_start(*entry);
}

void GuiFactory::add_singlechoice(const std::string &name,
                                  const std::vector<std::string> &values,
                                  const std::string &def /*= ""*/)
{
  HBox *hbox = new HBox();
  Label *lbl = new Label(name);
  ComboBox *combo = new ComboBox();

  if (!m_current_page)
    return;
  m_current_page->pack_start(*hbox);
  hbox->pack_start(*lbl);
  hbox->pack_start(*combo);

}

