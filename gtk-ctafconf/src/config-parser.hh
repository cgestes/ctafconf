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

#ifndef   	CONFIG_PARSER_HH_
# define   	CONFIG_PARSER_HH_

# include <gtkmm.h>
# include <fstream>
# include "config-object.hh"

class ConfigParser {
 public:
  typedef std::vector<ConfigObject *> ConfigList;
  typedef ConfigList::iterator iterator;

 public:
  ConfigParser();

  void load(const std::string &xmlfile);
  void save(const std::string &outputfile);
  void parse(const std::string &fname);

  const ConfigList &const_values() { return m_values; }
  ConfigList &values() { return m_values; }

  iterator begin() { return m_values.begin(); }
  iterator end() { return m_values.end(); }

 protected:
  bool getLine(std::ifstream &f);
  void parseInclude(std::ifstream &f);
  void parseComment(std::ifstream &f);
  void parseConfig(std::ifstream &f);
  void parseSubConfig(std::ifstream &f);

 private:
  std::string   m_current_line;
  ConfigList    m_values;
  ConfigObject  *m_current_cfg;
  unsigned int  m_line;
};

#endif 	    /* !CONFIG_PARSER_H_ */
