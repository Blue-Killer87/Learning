bin_PROGRAMS=reverse
dist_bin_SCRIPTS=example.sh
noinst_PROGRAMS=test

test_SOURCES=test.c
reverse_SOURCES=reverse.c

AM_CPPFLAGS=-I$(top_srcdir)/include -include $(top_srcdir)/config.h
reverse_LDFLAGS=-L$(top_srcdir)/src/.libs -lxlist -llist
