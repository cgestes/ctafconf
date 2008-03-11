/*
** stringutils.hh
** Login : <ctaf42@localhost.localdomain>
** Started on  Wed Mar  5 01:45:08 2008 Cedric GESTES
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

#ifndef   	STRINGUTILS_HH_
# define   	STRINGUTILS_HH_

#define SPACES " \t\r\n"

inline std::string trim_right (const std::string & s, const std::string & t = SPACES)
{
  std::string d (s);
  std::string::size_type i (d.find_last_not_of (t));
  if (i == std::string::npos)
    return "";
  else
    return d.erase (d.find_last_not_of (t) + 1) ;
}  // end of trim_right

inline std::string trim_left (const std::string & s, const std::string & t = SPACES)
{
  std::string d (s);
  return d.erase (0, s.find_first_not_of (t)) ;
}  // end of trim_left

inline std::string trim (const std::string & s, const std::string & t = SPACES)
{
  std::string d (s);
  return trim_left (trim_right (d, t), t) ;
}  // end of trim


inline std::string vector2string(const std::vector<std::string> &strings, const std::string separator)
{
  std::string result;

  return result;
}

inline std::vector<std::string> string2vector(const std::string, const std::string separator)
{
  std::vector<std::string> v;

  return v;
}

inline std::string trimquote(const std::string totrim)
{
  size_t pos, pos2;

  pos = totrim.find_first_of("'\"");

  if (pos != std::string::npos)
  {
    pos2 = totrim.find_last_of(totrim[pos]);
    return totrim.substr(pos + 1, pos2 - pos - 1);
  }
  return totrim;
}

#endif	    /* !STRINGUTILS_HH_ */
