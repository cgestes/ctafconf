/*
** config-regexp.cc
** Login : <ctaf42@localhost.localdomain>
** Started on  Wed Mar  5 00:09:00 2008 Cedric GESTES
** $Id$
**
** Author(s):
**  - Cedric GESTES <ctaf42@gmail.com>
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
#include <fstream>
#include "config-parser.hh"
#include "config-regexp.hh"


#include <boost/regex.hpp>

void ConfigRegexp::openFile(const std::string &fname)
{
  std::cout << "processing file:" << fname << std::endl;
  f.open(fname.c_str());
  if (f.bad())
  {
    std::cerr << "Cant open file: " << "user-profile" << std::endl;
    return;
  }
}


void ConfigRegexp::setValue(ConfigParser::ConfigList::iterator it,
                            const std::string &name,
                            const std::string &value,
                            const std::string &regexp)
{
  boost::smatch what;
  boost::regex re;

  re.assign(regexp);
  while (!f.eof())
  {
    std::string line;
    getline(f, line);
    bool result = boost::regex_search(line, what, re);
    if (result)
    {
    }
  }

}

/**
 * add a read key into the config object, if we find the value in the file
 * try the regexp on each line, return on the first match
 */
std::string ConfigRegexp::getValue(ConfigParser::ConfigList::iterator it,
                                   const std::string &name,
                                   const std::string &regexp)
{
  ConfigObject::ConfigKeys &keys = (*it)->keys();
  boost::smatch what;
  boost::regex re;

  re.assign(regexp);
  while (!f.eof())
  {
    std::string line;
    bool result;

    getline(f, line);
    result = boost::regex_search(line, what, re);
    if (result && what[1] == name)
    {
      keys.insert(std::make_pair("read", std::string(what[2])));
      return what[2];
    }
  }
  return "";
}

/*
 * loop through the configlist
 */
void ConfigRegexp::process(ConfigParser::ConfigList &config)
{
  ConfigParser::ConfigList::iterator it = config.begin();

  for (;it != config.end(); ++it)
  {
    const std::string &type = (*it)->type();
    const std::string &name = (*it)->name();
    const ConfigObject::ConfigKeys &keys = (*it)->keys();
    const ConfigObject::ConfigKeys::const_iterator it2 = keys.find("getregexp");

    if (type == "input")
    {
      openFile(name);
      continue;
    }

    if (it2 != keys.end())
    {
      const std::string &def = (*it2).second;
//       processValue(it, def);
      getValue(it, name, def);
    }

  }
}
