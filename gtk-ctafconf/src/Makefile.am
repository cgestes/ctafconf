## Process this file with automake to produce Makefile.in

bin_PROGRAMS = gtk-ctafconf

gtk_ctafconf_SOURCES =  main.cc		\
			gui-factory.cc	\
			config-parser.cc\
			config-regexp.cc\
			config-object.cc

gtk_ctafconf_LDFLAGS = $(BOOST_LDFLAGS)

gtk_ctafconf_CXXFLAGS =	 $(LIBGTKMM_CFLAGS) 	\
		         $(LIBGTKMM_DEBUG) 		\
		         $(BOOST_CFLAGS) 		\
		 	 -Wall

gtk_ctafconf_LDADD = $(LIBGTKMM_LIBS) $(BOOST_REGEX_LIB)

EXTRA_DIST = $(glade_DATA)
