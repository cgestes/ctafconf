/*
** config-regexp.hh
** Login : <ctaf42@localhost.localdomain>
** Started on  Wed Mar  5 00:09:21 2008 Cedric GESTES
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

#ifndef   	CONFIG_REGEXP_HH_
# define   	CONFIG_REGEXP_HH_

#include "config-parser.h"
class ConfigRegexp
{
public:
  ConfigRegexp(){;}

  void process(ConfigParser::ConfigList &config);
  void test();

protected:
  void openFile(const std::string &fname);
  std::string getValue(ConfigParser::ConfigList::iterator it, const std::string &name,  const std::string &regexp);
  void setValue(ConfigParser::ConfigList::iterator it,
                const std::string &name,
                const std::string &value,
                const std::string &regexp);

private:
  std::ifstream f;
};

#endif	    /* !CONFIG_REGEXP_HH_ */
