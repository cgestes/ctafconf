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
#include <boost/regex.hpp>
#include "config-parser.hh"
#include "config-regexp.hh"



/*!
** open a file as data to match
**
** @param fname
*/
void ConfigRegexp::openFile(const std::string &fname)
{
  std::string fn(fname);

  fn = "/home/ctaf42/.config/ctafconf/perso/" + fn;
  std::cout << "processing file:" << fn << std::endl;
  f.close();
  f.open(fn.c_str());
  if (!f.is_open())
  {
    std::cerr << "Cant open file: " << fn << std::endl;
    return;
  }
}

/*!
** replace the value of a key in a file
**
** @param it
** @param name
** @param value
** @param regexp
*/
bool ConfigRegexp::setValue(ConfigParser::ConfigList::iterator it,
                            const std::string &name,
                            const std::string &value,
                            const std::string &regexp)
{
  boost::smatch what;
  boost::regex re;
  ptrRegexpMatcher pRegexp;
//  ConfigObject::ConfigKeys &keys = (*it)->keys();
  iterator it2 = regexps.find(regexp);

  if (it2 != regexps.end())
    pRegexp = (*it2).second;

  if (!pRegexp)
  {
    std::cerr << "Cant find regexp: " << regexp << std::endl;
    return 0;
  }

  if (!f.is_open())
  {
    std::cerr << "bad file" << std::endl;
    return 0;
  }
  while (!f.eof())
  {
    std::string line;
    bool result;

    if (!getline(f, line))
    {
      std::cerr << "getline failed" << std::endl;
      break;
    }
    result = boost::regex_search(line, what, pRegexp->read);
    if (result && what[1] == name)
    {
      std::cout << "replace:" <<  name << " =       " << std::string(what[2]) << " ===> " << value << std::endl;
//      result = boost::regex_replace(line, what, pRegexp->read);

      return 0;
    }
  }
//   re.assign(regexp);
//   while (!f.eof())
//   {
//     std::string line;
//     getline(f, line);
//     bool result = boost::regex_search(line, what, re);
//     if (result)
//     {
//     }
//   }
  return 1;
}

/*
** add a 'read' key to config object when we find a match in the file.
**  try the regexp on each line, return on the first match
**
** @param it
** @param name
** @param regexp
**
** @return
*/
std::string ConfigRegexp::getValue(ConfigParser::ConfigList::iterator it,
                                   const std::string &name,
                                   const std::string &regexp)
{
  ConfigObject::ConfigKeys &keys = (*it)->keys();
  boost::smatch what;
  boost::regex re;
  ptrRegexpMatcher pRegexp;

  iterator it2 = regexps.find(regexp);

  if (it2 != regexps.end())
    pRegexp = (*it2).second;

  if (!pRegexp)
  {
    std::cerr << "Cant find regexp: " << regexp << std::endl;
    return "";
  }

  if (!f.is_open())
  {
    std::cerr << "bad file" << std::endl;
    return "";
  }
  while (!f.eof())
  {
    std::string line;
    bool result;

    if (!getline(f, line))
    {
      std::cerr << "getline failed" << std::endl;
      break;
    }
    result = boost::regex_search(line, what, pRegexp->read);
    if (result && what[1] == name)
    {
      keys.insert(std::make_pair("read", std::string(what[2])));
      return what[2];
    }
  }
  return "";
}

/*!
** add a regexp to the list of available regexp
**
** @param it
** @param name
*/
void ConfigRegexp::addRegexp(ConfigParser::iterator &it, const std::string &name)
{
  ConfigObject::ConfigKeys &keys = (*it)->keys();
  ConfigObject::ConfigKeys::const_iterator it2 = keys.find("readregexp");
  ConfigObject::ConfigKeys::const_iterator it3 = keys.find("writeregexp");

  if (it2 != keys.end() || it3 != keys.end())
  {
    std::string rregexp;
    std::string wregexp;

    ptrRegexpMatcher pregexp = ptrRegexpMatcher(new RegexpMatcher());


    if (it2 != keys.end())
    {
      rregexp = (*it2).second;
      pregexp->read.assign(rregexp);
    }

    if (it3 != keys.end())
    {
      wregexp = (*it2).second;
      pregexp->write.assign(wregexp);
    }
    regexps[name] = pregexp;
  }
}

/**
 * update the open file list
 * and the regexp list
 */
void ConfigRegexp::update(ConfigParser::ConfigList &config)
{
  ConfigParser::iterator it = config.begin();

  for (;it != config.end(); ++it)
  {
    const std::string &type = (*it)->type();
    const std::string &name = (*it)->name();

    if (type == "regexp")
    {
      addRegexp(it, name);
      continue;
    }
  }

}

/*
 * loop through the configlist
 */
void ConfigRegexp::process(ConfigParser::ConfigList &config)
{
  ConfigParser::iterator it = config.begin();

  update(config);

  for (;it != config.end(); ++it)
  {
    const std::string &type = (*it)->type();
    const std::string &name = (*it)->name();
    const ConfigObject::ConfigKeys &keys = (*it)->keys();
    const ConfigObject::ConfigKeys::const_iterator it2 = keys.find("regexp");

    if (type == "input")
    {
      openFile(name);
      continue;
    }

    if (it2 != keys.end())
    {
      const std::string &def = (*it2).second;
      getValue(it, name, def);
    }
  }
}

/*
 * loop through the configlist
 */
void ConfigRegexp::write(ConfigParser::ConfigList &config)
{
  ConfigParser::iterator it = config.begin();

  update(config);

  for (;it != config.end(); ++it)
  {
    const std::string &type = (*it)->type();
    const std::string &name = (*it)->name();
    const ConfigObject::ConfigKeys &keys = (*it)->keys();
    const ConfigObject::ConfigKeys::const_iterator it2 = keys.find("regexp");
    const ConfigObject::ConfigKeys::const_iterator it3 = keys.find("write");

    if (type == "input")
    {
      openFile(name);
      continue;
    }

    if (it2 != keys.end() && it3 != keys.end())
    {
      const std::string &regexp = (*it2).second;
      const std::string &value = (*it3).second;

      setValue(it, name, value, regexp);
    }
    else
      std::cerr << "warning;regexp::write: no write value, or no regexp" << std::endl;

  }
}
