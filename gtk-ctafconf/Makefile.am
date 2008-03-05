## Process this file with automake to produce Makefile.in
## Created by Anjuta

SUBDIRS = src po

gtk_ctafconfdocdir = ${prefix}/doc/gtk-ctafconf
gtk_ctafconfdoc_DATA = \
	README\
	COPYING\
	AUTHORS\
	ChangeLog\
	INSTALL\
	NEWS

ACLOCAL_AMFLAGS = -I config/m4

EXTRA_DIST = $(gtk_ctafconfdoc_DATA) \
	     config/m4

# Copy all the spec files. Of cource, only one is actually used.
dist-hook:
	for specfile in *.spec; do \
		if test -f $$specfile; then \
			cp -p $$specfile $(distdir); \
		fi \
	done

