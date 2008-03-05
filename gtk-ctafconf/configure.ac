dnl Process this file with autoconf to produce a configure script.
dnl Created by Anjuta application wizard.

AC_INIT(gtk-ctafconf, 0.1)

dnl define the config folder for autotools (for make dist)
AC_CONFIG_AUX_DIR(config)

dnl define the m4 files for autotools (for make dist)
AC_CONFIG_MACRO_DIR([config/m4])

AM_INIT_AUTOMAKE(AC_PACKAGE_NAME, AC_PACKAGE_VERSION)

dnl AC_CONFIG_SRCDIR([src/main.cc])

dnl create a header that contain each define
AM_CONFIG_HEADER(config.h)

dnl AM_MAINTAINER_MODE


dnl AC_ISC_POSIX
AC_PROG_INSTALL

dnl AC_PROG_LIBTOOL

dnl use a cpp compiler
AC_PROG_CXX

dnl AM_PROG_CC_STDC
dnl AC_HEADER_STDC




dnl ***************************************************************************
dnl Internatinalization
dnl ***************************************************************************
GETTEXT_PACKAGE=gtk-ctafconf
AC_SUBST(GETTEXT_PACKAGE)
AC_DEFINE_UNQUOTED(GETTEXT_PACKAGE,"$GETTEXT_PACKAGE", [GETTEXT package name])
AM_GLIB_GNU_GETTEXT
IT_PROG_INTLTOOL([0.35.0])



dnl check for each module
PKG_CHECK_MODULES(LIBGTKMM, [gtkmm-2.4 >= 2.8])

dnl define substitute
AC_SUBST(LIBGTKMM_CFLAGS)
AC_SUBST(LIBGTKMM_LIBS)

dnl check for boost/regex
AX_BOOST_BASE([1.34])
AX_BOOST_REGEX

dnl #define in config.h
AX_DEFINE_DIR(GTK_CTAFCONF_DATADIR, "${datadir}/$PACKAGE", "data folder")

dnl used by data/Makefile.am
AC_SUBST(GTK_CTAFCONF_DATADIR, "${datadir}/$PACKAGE")


dnl --enable-debug to debug
AC_ARG_ENABLE(debug,
 [  --enable-debug            enable debug],
 if test "x$enableval" = xyes; then
   AC_SUBST(GTK_CTAFCONF_DEBUG, "-g")
 fi
 )

dnl AC_SUBST(CT_DATADIR)
dnl echo DIR: ${CT_DATADIR} , datadir: ${datadir}
dnl echo DIR: ${CT_DATADIR2} , datadir: ${datadir}

AC_OUTPUT([
Makefile
src/Makefile
po/Makefile.in
data/Makefile
])
