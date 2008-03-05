## Process this file with automake to produce Makefile.in

## Created by Anjuta

INCLUDES = \
	-DPACKAGE_LOCALE_DIR=\""$(prefix)/$(DATADIRNAME)/locale"\" \
	-DPACKAGE_SRC_DIR=\""$(srcdir)"\" \
	-DPACKAGE_DATA_DIR=\""$(datadir)"\" \
	$(GTK_CTAFCONF_CFLAGS)


bin_PROGRAMS = gtk-ctafconf

gtk_ctafconf_SOURCES = 			\
			main.c		\
			gui-factory.cc	\
			config-parser.cc\
			config-regexp.cc

gtk_ctafconf_LDFLAGS = $(BOOST_LDFLAGS)

gtk_ctafconf_CXXFLAGS =			\
	 		 -Wall\
			 -g $(BOSST_CFLAGS)

gtk_ctafconf_LDADD = $(GTK_CTAFCONF_LIBS) $(BOOST_REGEX_LIB)

EXTRA_DIST = $(glade_DATA)
