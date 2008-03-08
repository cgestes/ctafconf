/*
** config-object.cc
** Login : <ctaf@wei>
** Started on  Wed Mar  5 16:13:53 2008 Cedric GESTES
** $Id$
**
** Author(s):
**  - Cedric GESTES <gestes@aldebaran-robotics.com>
**
** Copyright (C) 2008 Cedric GESTES
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
#include "config-object.hh"
#include "config-regexp.hh"


ConfigObject::ConfigObject(const std::string &type, const std::string &name)
{
  m_name = name;
  m_type = type;
}


void ConfigObject::addKey(const std::string &name, const std::string &value)
{
  m_keys.insert(make_pair(name, value));
}

unsigned int  ConfigObject::getBool(const std::string &name, bool &value)
{
  iterator it;
  it = m_keys.find(name);

  if (it != m_keys.end())
  {
    const std::string &val = (*it).second;
    if (val == "t" ||
        val == "true" ||
        val == "T" ||
        val == "TRUE" ||
        val == "1" ||
        val == "y" ||
        val == "Y" ||
        val == "o" ||
        val == "O" )
      value = true;
    else
      value = false;
    return 1;
  }
  return 0;
}

unsigned int ConfigObject::getString(const std::string &name, std::string &value)
{
  iterator it;
  it = m_keys.find(name);

  if (it != m_keys.end())
  {
    value = (*it).second;
//     std::cout << "getString(" << name << ", " << value << ")" << std::endl;
    return 1;
  }
  return 0;
}

unsigned int ConfigObject::getStringsFormated(const std::string &name, std::vector<std::string> &values)
{

}

unsigned int ConfigObject::getStrings(const std::string &name, std::vector<std::string> &values)
{
  std::pair<iterator, iterator> pair;
  iterator it;

  pair = m_keys.equal_range(name);
  for (it = pair.first; it != pair.second; ++it)
  {
    values.push_back((*it).second);
  }
  return m_keys.count(name);
}


void ConfigObject::setBool(const std::string &name, const bool value)
{
  std::string strue, sfalse, svalue, regexp;
  iterator it;

  if (!m_regexp)
  {
    std::cerr << "error: setBool: cant find a regexp" << std::endl;
    return;
  }

  m_regexp->config->getString("true", strue);
  m_regexp->config->getString("false", sfalse);


  svalue = (value ? strue : sfalse);
//   std::cout << "setBool(" << name << ", " << svalue << ")" << std::endl;
  it = m_keys.find(name);
  if (it != m_keys.end())
    (*it).second = svalue;
  else
    m_keys.insert(make_pair(name, svalue));

}

void ConfigObject::setString(const std::string &name, const std::string &value)
{
  iterator it;
  it = m_keys.find(name);

  if (it != m_keys.end())
    (*it).second = value;
  else
    m_keys.insert(make_pair(name, value));
}

void ConfigObject::setStringsFormated(const std::string &name, const std::vector<std::string> &values)
{
}

/*
 * set a list of string
 */
void ConfigObject::setStrings(const std::string &name, const std::vector<std::string> &values)
{
  std::pair<iterator, iterator> pair;
  std::string value;
  std::vector<std::string>::const_iterator it = values.begin();

  pair = m_keys.equal_range(name);
  m_keys.erase(pair.first, pair.second);

  value = "'";
  for (; it != values.end(); ++it)
  {
    if ((it + 1) == values.end())
      value += (*it);
    else
      value += (*it) + ", ";
  }
  value += "'";
  std::cout << "setStrings(" << name << "):" << value << std::endl;
  m_keys.insert(make_pair(name, value));

}
