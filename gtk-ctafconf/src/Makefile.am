## Process this file with automake to produce Makefile.in

## Created by Anjuta

gladedir = $(datadir)/gtk-ctafconf/glade
glade_DATA = gtk-ctafconf.glade

INCLUDES = \
	-DPACKAGE_LOCALE_DIR=\""$(prefix)/$(DATADIRNAME)/locale"\" \
	-DPACKAGE_SRC_DIR=\""$(srcdir)"\" \
	-DPACKAGE_DATA_DIR=\""$(datadir)"\" \
	$(GTK_CTAFCONF_CFLAGS)

AM_CFLAGS =\
	 -Wall\
	 -g

bin_PROGRAMS = gtk-ctafconf

gtk_ctafconf_SOURCES = 			\
			main.c		\
			gui-factory.cc

gtk_ctafconf_LDFLAGS =

gtk_ctafconf_LDADD = $(GTK_CTAFCONF_LIBS)

EXTRA_DIST = $(glade_DATA)
