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


ConfigObject::ConfigObject(const std::string &type, const std::string &name)
{
  m_name = name;
  m_type = type;
}


void ConfigObject::addKey(const std::string &name, const std::string &value)
{
  m_keys.insert(make_pair(name, value));
}
