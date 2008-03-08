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
#include <config.h>

#include "config-parser.hh"
#include "string-utils.hh"

using namespace std;

ConfigParser::ConfigParser()
{
  m_line = 0;
}

bool ConfigParser::getLine(std::ifstream &f)
{
  bool ret;

  if (!(ret = getline(f, m_current_line)))
  {
    std::cerr << "getline failed" << std::endl;
    return false;
  }
  m_current_line = trim(m_current_line);
  m_line++;
  return true;
}

void ConfigParser::parseComment(std::ifstream &f)
{
  while (m_current_line[0] == '#')
  {
    if (!getLine(f))
      break;
  }
}
void ConfigParser::parseInclude(std::ifstream &f)
{
  if (m_current_line.substr(0, 8) == "include:")
  {
    string::size_type i (m_current_line.find_first_of (":"));
    string type = trim(m_current_line.substr(0, i));
    const string name = trim(m_current_line.substr(i + 1));
    std::string fname;
    if (m_current_cfg)
      m_values.push_back(m_current_cfg);
    m_current_cfg = ConfigObject::ptr(new ConfigObject(type, name));

    fname = GTK_CTAFCONF_DATADIR;
    fname += "/template/";
    fname += name;
    std::cout << "include:" << fname << std::endl;
    parse(fname);

  }
}

void ConfigParser::parseConfig(std::ifstream &f)
{
  string::size_type i (m_current_line.find_first_of (":"));

  //match
  if (i != std::string::npos)
  {
    string type = trim(m_current_line.substr(0, i));
    const string name = trim(m_current_line.substr(i + 1));

    getLine(f);

    if (m_current_cfg)
      m_values.push_back(m_current_cfg);
    m_current_cfg = ConfigObject::ptr(new ConfigObject(type, name));
  }

}

void ConfigParser::parseSubConfig(std::ifstream &f)
{
  string::size_type i (m_current_line.find_first_of ("="));

  //match
  if (i != std::string::npos)
  {
    const string name = trim(m_current_line.substr(0, i));
    const string value = trim(m_current_line.substr(i + 1));

    if (m_current_cfg)
      m_current_cfg->addKey(name, value);
    getLine(f);
  }

}

void ConfigParser::parse(const std::string &fname)
{
  std::string tmp;
  std::ifstream f;

  f.open(fname.c_str());

  if (!f.is_open())
  {
    std::cerr << "cant open file:" << fname << std::endl;
    return;
  }
  getLine(f);
  while (!f.eof())
  {
    unsigned int curln = m_line;
    parseInclude(f);
    parseComment(f);
    parseConfig(f);
    parseComment(f);
    parseSubConfig(f);
    //no parsed data, manually skip current line
    if (m_line == curln)
    {
      if (!getLine(f))
        break;
    }
  }
  f.close();
}
