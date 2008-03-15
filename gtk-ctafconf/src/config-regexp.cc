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

#include <cstdlib>
#include <iostream>
#include <fstream>
#include <boost/regex.hpp>

#include "config-parser.hh"
#include "config-regexp.hh"

void ConfigRegexp::fileWrite()
{
  std::string           fnprev;
  std::string           arg;
  std::ofstream         fo;


  std::cout << "fo_name:" << fo_name << std::endl;
  if (fo_name.empty())
    return;

  /*
   * copy the previous file before writing into it
   */
  fnprev = fo_name + ".prev";
  arg = "cp " + fo_name + " " + fnprev;
  system(arg.c_str());
  fo.open(fo_name.c_str());
  if (fo.is_open())
  {
    strings::iterator itstr;
    std::cout << "writing:" << std::endl;

    for (itstr = lines.begin(); itstr != lines.end(); itstr++)
    {
      fo << *itstr << std::endl;
      std::cout << *itstr << std::endl;
    }
  }
  lines.clear();
  fo.close();
}


/**
 * read the input buffer
 */
void ConfigRegexp::fileRead(const std::string &fname)
{
  std::ifstream         fi;
  std::string           fn;

  fn = getenv("HOME");
  fn += "/.config/ctafconf/perso/" + fname;

  //open the new file
  std::cout << "processing file:" << fn << std::endl;
  fi.open(fn.c_str());
  if (!fi.is_open())
  {
    std::cerr << "fi: Cant open file: " << fn << std::endl;
    return;
  }

  //read lines
  lines.clear();
  while (!fi.eof())
  {
    std::string line;
    if (getline(fi, line))
      lines.push_back(line);
  }
  fi.close();
}

/*
 * 1) write the previous file
 * 2) copy the filename for later call
 *
 * @param fname
 */
void ConfigRegexp::fileWriteNext(const std::string &fname)
{
  std::string           fn;

  fn = getenv("HOME");
  fn += "/.config/ctafconf/perso/" + fname;

  if (!fo_name.empty())
    fileWrite();
  fo_name = fn;
  fileRead(fname);
}

/*!
** replace the value of a key in a file
**
** @param it
** @param name
** @param value
** @param regexp
*/
bool ConfigRegexp::setValue(ConfigObject::ptr obj,
                            const std::string &name,
                            const std::string &value,
                            const std::string &regexp)
{
  boost::smatch what;
  boost::regex re;
  RegexpMatcher::ptr pRegexp;
  iterator itre = regexps.find(regexp);
  strings::iterator itstr;

  if (itre != regexps.end())
    pRegexp = (*itre).second;

  if (!pRegexp)
  {
    std::cerr << "Cant find regexp: " << regexp << std::endl;
    return 0;
  }

  for (itstr = lines.begin(); itstr != lines.end(); itstr++)
  {
    std::string line;
    bool result;

    line = *itstr;
    result = boost::regex_search(line, what, pRegexp->read);
    if (result && what[1] == name)
    {
      std::string regexp = pRegexp->write;
      std::string r = what[2];
      size_t pos = regexp.find("%$$%");

      if (pos == std::string::npos)
      {
        std::cout << "bad regexp" << std::endl;
        continue;
      }
      regexp.replace(pos, 4, value);

      std::string res = boost::regex_replace(line, pRegexp->read, regexp);
      std::cout << " -- result : " << res << std::endl;

      /* set the new value for the read (because we may compare with it, next time configregexp::write is called) */
      obj->setString("read", value);

      *itstr = res;
      return 1;
    }
  }
  std::cout << "no match for:" << name << std::endl;

  return 0;
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
std::string ConfigRegexp::getValue(ConfigObject::ptr obj,
                                   const std::string &name,
                                   const std::string &regexp)
{
  boost::smatch what;
  boost::regex re;
  RegexpMatcher::ptr pRegexp;
  iterator itre = regexps.find(regexp);
  strings::iterator itstr;

  if (itre != regexps.end())
    pRegexp = (*itre).second;

  if (!pRegexp)
  {
    std::cerr << "Cant find regexp: " << regexp << std::endl;
    return "";
  }

  for (itstr = lines.begin(); itstr != lines.end(); itstr++)
  {
    std::string line;
    bool result;

    line = *itstr;
    result = boost::regex_search(line, what, pRegexp->read);
    if (result && what[1] == name)
    {
      obj->setString("read", std::string(what[2]));
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
void ConfigRegexp::addRegexp(ConfigObject::ptr obj, const std::string &name)
{
  std::string rregexp;
  std::string wregexp;

  RegexpMatcher::ptr pregexp = RegexpMatcher::ptr(new RegexpMatcher());

  if (obj->getString("readregexp", rregexp))
  {
    pregexp->read.assign(rregexp);
  }

  if (obj->getString("writeregexp", wregexp))
  {
    pregexp->write = wregexp;
  }
  pregexp->config = obj;

  regexps[name] = pregexp;
}

/**
 * update the open file list
 * and the regexp list
 */
void ConfigRegexp::update(ConfigParser &config)
{
  ConfigParser::iterator it = config.begin();

  for (;it != config.end(); ++it)
  {
    ConfigObject::ptr obj = (*it);
    const std::string &type = obj->type();
    const std::string &name = obj->name();

    if (type == "regexp")
    {
      addRegexp(obj, name);
      continue;
    }
  }

}

/*
 * loop through the configlist
 */
void ConfigRegexp::read(ConfigParser &config)
{
  ConfigParser::iterator it = config.begin();
  RegexpMatcher::ptr preg;

  update(config);

  for (;it != config.end(); ++it)
  {
    ConfigObject::ptr obj = (*it);
    const std::string &type = obj->type();
    const std::string &name = obj->name();
    std::string regexp;

    if (type == "input")
    {
      fileRead(name);
      continue;
    }

    if (obj->getString("regexp", regexp))
    {
      iterator itreg = regexps.find(regexp);
      if (itreg != regexps.end())
        obj->setRegexp((*itreg).second);
      obj->erase(name);
      getValue(obj, name, regexp);
    }
  }
}

/*
 * loop through the configlist
 */
void ConfigRegexp::write(ConfigParser &config)
{
  ConfigParser::iterator it = config.begin();

  update(config);

  for (;it != config.end(); ++it)
  {
    ConfigObject::ptr obj = (*it);
    const std::string &type = obj->type();
    const std::string &name = obj->name();
    std::string regexp, value, prevvalue;

    if (type == "input")
    {
      fileWriteNext(name);
      continue;
    }

    if (obj->getString("regexp", regexp) && obj->getString("write", value))
    {
      if (obj->getString("read", prevvalue) &&
          prevvalue == value)
        continue;
      setValue(obj, name, value, regexp);
    }
  }
  fileWrite();
}
