/*
** config-parser.h
** Login : <ctaf@ctaf-laptop>
** Started on  Wed Feb 13 21:04:37 2008 GESTES Cedric
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

#ifndef   	CONFIG_OBJECT_HH_
# define   	CONFIG_OBJECT_HH_

# include <gtkmm.h>
# include <fstream>

class ConfigObject {
 public:
  typedef std::multimap<std::string, std::string> ConfigKeys;
  typedef ConfigKeys::iterator iterator;

  ConfigObject(const std::string &type, const std::string &name);
  void addKey(const std::string &name, const std::string &value);


  const std::string &name() { return m_name; }
  const std::string &type() { return m_type; }

  const ConfigKeys &const_keys() { return m_keys; }
  ConfigKeys &keys() { return m_keys; }

  iterator begin() { return m_keys.begin(); }
  iterator end() { return m_keys.end(); }

 protected:

 public:
  std::string m_name;
  std::string m_type;
  Gtk::Widget *widget;
  ConfigKeys m_keys;
};


#endif 	    /* !CONFIG_OBJECT_HH_ */
