
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
#include "string-utils.hh"


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
  std::vector<std::string> trues;
  std::vector<std::string> falses;
  std::vector<std::string>::iterator itval;

  if (it != m_keys.end())
  {
    const std::string &val = (*it).second;
    if (m_regexp && m_regexp->config)
    {
      m_regexp->config->getStrings("true", trues);
      m_regexp->config->getStrings("false", falses);
    }
    for (itval = trues.begin(); itval != trues.end();++itval)
    {
      if (val == *itval)
      {
        value = true;
        return 1;
      }
    }
    for (itval = falses.begin(); itval != falses.end();++itval)
    {
      if (val == *itval)
      {
        value = false;
        return 1;
      }
    }
    return 0;
  }
  return 0;
}

unsigned int ConfigObject::getStringQuoted(const std::string &name, std::string &value)
{
  unsigned int ret;
  if ((ret = getString(name, value)))
    value = trimquote(value);
  return ret;
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
  iterator it;
  size_t pos = 0;
  size_t prev_pos = 0;

  it = m_keys.find(name);

  if (it != m_keys.end())
  {
    std::string block;
    std::string value = (*it).second;
    value = trim(value);
    value = trimquote(value);
    std::cout << "value:" << value << std::endl;
    pos = value.find_first_of(SPACES);
    while (pos != std::string::npos)
    {
      block = value.substr(prev_pos, pos - prev_pos);
      block = trim(block);
      std::cout << "block:" << block << std::endl;
      values.push_back(block);
      prev_pos = pos + 1;
      pos = value.find_first_of(SPACES, prev_pos);
    }

    block = value.substr(prev_pos, pos - prev_pos);
    block = trim(block);
    std::cout << "block:" << block << std::endl;
    values.push_back(block);


    return 1;
  }
  return 0;
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

void ConfigObject::setStringQuoted(const std::string &name, const std::string &value, const std::string &quote)
{
  std::string val;
  if (getString(quote, val))
  {
    trim(quote);
    if (val[0] == '"' || val[0] == '\'')
    {
      setString(name, val[0] + value + val[0]);
      return;
    }
  }
  val = "";
  if (m_regexp && m_regexp->config)
  {
    m_regexp->config->getString("defaultquote", val);
  }
  setString(name, val + value + val);
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
//   std::pair<iterator, iterator> pair;
  std::string value;
  std::vector<std::string>::const_iterator it = values.begin();

//   pair = m_keys.equal_range(name);
//   m_keys.erase(pair.first, pair.second);

  value = "'";
  for (; it != values.end(); ++it)
  {
    if ((it + 1) == values.end())
      value += (*it);
    else
      value += (*it) + " ";
  }
  value += "'";
  std::cout << "setStringsFormated(" << name << "):" << value << std::endl;
  setString(name, value);


}

/*
 * set a list of string
 */
void ConfigObject::setStrings(const std::string &name, const std::vector<std::string> &values)
{
  std::pair<iterator, iterator> pair;
  std::vector<std::string>::const_iterator it = values.begin();

  pair = m_keys.equal_range(name);
  m_keys.erase(pair.first, pair.second);

  for (; it != values.end(); ++it)
    m_keys.insert(make_pair(name, *it));
}

void ConfigObject::erase(const std::string &name)
{
   std::pair<iterator, iterator> pair;

   pair = m_keys.equal_range(name);
   m_keys.erase(pair.first, pair.second);
}
