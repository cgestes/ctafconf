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
# include <boost/shared_ptr.hpp>

class ComboModelColumns;
class RegexpMatcher;
typedef boost::shared_ptr<RegexpMatcher> RegexpMatcherPtr;

class ConfigObject {
protected:
  typedef std::multimap<std::string, std::string> ConfigKeys;

 public:
  typedef ConfigKeys::iterator iterator;
  typedef boost::shared_ptr<ConfigObject> ptr;
  typedef std::vector<std::string> strings;

  ConfigObject(const std::string &type, const std::string &name);

/**
 * only used by the parser
 */
  void addKey(const std::string &name, const std::string &value);

  unsigned int getBool(const std::string &name, bool &value);
  void setBool(const std::string &name, const bool value);

  unsigned int getString(const std::string &name, std::string &value);
  unsigned int getStringQuoted(const std::string &name, std::string &value);

  void setString(const std::string &name, const std::string &value);
  void setStringQuoted(const std::string &name, const std::string &value, const std::string &quote);

  //get a range of string
  unsigned int getStrings(const std::string &name, std::vector<std::string> &values);
  //get a list of string from a single string
  unsigned int getStringsFormated(const std::string &name, std::vector<std::string> &values);

  void setStrings(const std::string &name, const std::vector<std::string> &values);
  //get a list of string from a single string
  void setStringsFormated(const std::string &name, const std::vector<std::string> &values);



  void erase(const std::string &name);

  const std::string &name()const { return m_name; }
  const std::string &type()const { return m_type; }

  RegexpMatcherPtr &regexp() { return m_regexp; }
  void setRegexp(const RegexpMatcherPtr &re) { m_regexp = re; }

//   const ConfigKeys &const_keys()const { return m_keys; }
//   ConfigKeys &keys() { return m_keys; }

//   iterator begin() { return m_keys.begin(); }
//   iterator end() { return m_keys.end(); }

 public:
  Gtk::Widget           *widget;
  ComboModelColumns     *columns;

 protected:
  RegexpMatcherPtr    m_regexp;
  std::string           m_name;
  std::string           m_type;
  ConfigKeys            m_keys;
};


#endif 	    /* !CONFIG_OBJECT_HH_ */
