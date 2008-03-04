/*
** config-parser.cc
** Login : <ctaf@ctaf-laptop>
** Started on  Wed Feb 13 22:36:06 2008 GESTES Cedric
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

#include <iostream>
#include <fstream>
#include <string>
#include "config-parser.h"

using namespace std;
#define SPACES " \t\r\n"

inline string trim_right (const string & s, const string & t = SPACES)
{
  string d (s);
  string::size_type i (d.find_last_not_of (t));
  if (i == string::npos)
    return "";
  else
    return d.erase (d.find_last_not_of (t) + 1) ;
}  // end of trim_right

inline string trim_left (const string & s, const string & t = SPACES)
{
  string d (s);
  return d.erase (0, s.find_first_not_of (t)) ;
}  // end of trim_left

inline string trim (const string & s, const string & t = SPACES)
{
  string d (s);
  return trim_left (trim_right (d, t), t) ;
}  // end of trim




ConfigObject::ConfigObject(const std::string &type, const std::string &name)
{
  m_name = name;
  m_type = type;
}


void ConfigObject::addKey(const std::string &name, const std::string &value)
{
  m_keys.insert(make_pair(name, value));
}

ConfigParser::ConfigParser()
{
  m_current_cfg = 0;
  m_line = 0;

}

void ConfigParser::getLine()
{
  m_line++;
  getline(f, m_current_line);
  m_current_line = trim(m_current_line);
//  m_current_line.trim();
}

void ConfigParser::parseComment()
{
  while (m_current_line[0] == '#')
  {
    getLine();
  }
}

void ConfigParser::parseConfig()
{
  string::size_type i (m_current_line.find_first_of (":"));

  //match
  if (i != -1)
  {
    string type = trim(m_current_line.substr(0, i));
    const string name = trim(m_current_line.substr(i + 1));

    getLine();

    if (m_current_cfg)
      m_values.push_back(m_current_cfg);
    m_current_cfg = new ConfigObject(type, name);
  }

}

void ConfigParser::parseSubConfig()
{
  string::size_type i (m_current_line.find_first_of ("="));

  //match
  if (i != -1)
  {
    const string name = trim(m_current_line.substr(0, i));
    const string value = trim(m_current_line.substr(i + 1));

    if (m_current_cfg)
      m_current_cfg->addKey(name, value);
    getLine();
  }

}

void ConfigParser::parse(const std::string &fname)
{
  std::string tmp;


  f.open(fname.c_str());

  if (!f.is_open())
  {
    std::cerr << "cant open file" << std::endl;
    return;
  }
  getLine();
  while (!f.eof())
  {
    unsigned int curln = m_line;
    parseComment();
    parseConfig();
    parseComment();
    parseSubConfig();
    //no parsed data, manually skip current line
    if (m_line == curln)
      getLine();
  }
  f.close();
}

void ConfigParser::save(const std::string &outputfile) {
//   ConfigList::iterator it(m_value);
//   Glib::RefPtr<ConfigObject> config;
//   for(;*it; ++it) {
//     config = *it;
//     save_object(config);
//   }
}
