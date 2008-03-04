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

#ifndef   	CONFIG_PARSER_H_
# define   	CONFIG_PARSER_H_

# include <gtkmm.h>
# include <fstream>

typedef enum {
  CF_STRING,
  CF_SINGLECHOICE,
  CF_MULTICHOICE
} ConfigType;

class ConfigObject {
 public:
  typedef std::multimap<std::string, std::string> ConfigKeys;

  ConfigObject(const std::string &type, const std::string &name);
  void addKey(const std::string &name, const std::string &value);

  const std::string &name() { return m_name; }
  const std::string &type() { return m_type; }
  const ConfigKeys &keys() { return m_keys; }

 protected:

 public:
  std::string m_name;
  std::string m_type;
/*   ConfigType type; */
  Gtk::Widget *widget;
  ConfigKeys m_keys;
};

class ConfigObjectString {
 public:
  std::vector<std::string> m_values;
  std::vector<std::string> m_defaults;
};

class ConfigParser {
 public:
  typedef std::vector<ConfigObject *> ConfigList;

 public:
  ConfigParser();

  void load(const std::string &xmlfile);
  void save(const std::string &outputfile);
  void parse(const std::string &fname);

  const ConfigList &values() { return m_values; }

 protected:
  void getLine();
  void parseComment();
  void parseConfig();
  void parseSubConfig();



/*   //parse different value type */
/*   Glib::RefPtr<ConfigObject> *parse_string(); */
/*   Glib::RefPtr<ConfigObject> *parse_singlelist(); */
/*   Glib::RefPtr<ConfigObject> *parse_multilist(); */

/*   //save value */
/*   void save_string(const Glib::RefPtr<ConfigObject> &config); */
/*   void save_singlelist(const Glib::RefPtr<ConfigObject> &config); */
/*   void save_multilist(const Glib::RefPtr<ConfigObject> &config); */


 private:
  std::ifstream f;
  std::string   m_current_line;
  ConfigList    m_values;
  ConfigObject  *m_current_cfg;
  unsigned int  m_line;
};

#endif 	    /* !CONFIG_PARSER_H_ */
