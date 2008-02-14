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
#include "config-parser.hh"


void ConfigParser::parse_string();
void ConfigParser::parse_combo();
void ConfigParser::parse_singlelist();
void ConfigParser::parse_multilist();

void ConfigParser::save_string(const Glib::RefPtr<ConfigObject> &config);
void ConfigParser::save_combo(const Glib::RefPtr<ConfigObject> &config);
void ConfigParser::save_singlelist(const Glib::RefPtr<ConfigObject> &config);
void ConfigParser::save_multilist(const Glib::RefPtr<ConfigObject> &config);

void ConfigParser::save_object(const Glib::RefPtr<ConfigObject> &config)
{
  switch(config->type) {
  case CF_STRING:
    save_string(config);
    break;
  case CF_COMBO:
    save_combo(config);
    break;
  case CF_SINGLELIST:
    save_singlelist(config);
    break;
  case CF_MULTILIST:
    save_multilist(config);
    break;
  }
}

void ConfigParser::save(const std::string &outputfile) {
  ConfigList::iterator it(m_value);
  Glib::RefPtr<ConfigObject> config;
  for(;*it; ++it) {
    config = *it;
    save_object(config);
  }
}
