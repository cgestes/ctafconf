/*
** configstore.h
** Login : <ctaf42@localhost.localdomain>
** Started on  Tue Feb 19 00:31:24 2008 Cedric GESTES
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

#ifndef   	CONFIGSTORE_H_
# define   	CONFIGSTORE_H_

class ConfigStore {
 public:
  typedef vector<Config> ConfigVector;

  void append();
  void get_config();

 protected:
  ConfigVector m_configs;

}

#endif 	    /* !CONFIGSTORE_H_ */
