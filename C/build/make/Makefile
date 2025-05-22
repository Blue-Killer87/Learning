LIST_SOURCES := list.c
XLIST_SOURCES := xlist.c
REVERSE_SOURCES := reverse.c

LIST_OBJS := $(patsubst %.c,%.o,$(LIST_SOURCES))
LIST_DEPS := list.h xref.h
XLIST_OBJS := $(patsubst %.c,%.o,$(XLIST_SOURCES))
XLIST_DEPS := xlist.h list.h xref.h
REVERSE_OBJS := $(patsubst %.c,%.o,$(REVERSE_SOURCES))
REVERSE_DEPS := xlist.h list.h xref.h

ifeq ($(CC),cc)
CC = gcc
endif
CFLAGS ?= -O2 -g3 -fPIC
CPPFLAGS += -I. -DHAVE_ATOMIC_GNUC

all: liblist.a liblist.so libxlist.a libxlist.so reverse

$(LIST_OBJS): $(LIST_SOURCES) $(LIST_DEPS)
$(XLIST_OBJS): $(XLIST_SOURCES) $(XLIST_DEPS)
$(REVERSE_OBJS): $(REVERSE_SOURCES) $(REVERSE_DEPS)

%.o: %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) -o $@ -c $<

liblist.a: $(LIST_OBJS) $(LIST_DEPS)
	$(AR) -crs liblist.a $(LIST_OBJS)

liblist.so: $(LIST_OBJS) $(LIST_DEPS)
	$(CC) -shared -o liblist.so $(LIST_OBJS)

libxlist.a: $(XLIST_OBJS) $(XLIST_DEPS)
	$(AR) -crs libxlist.a $(XLIST_OBJS)

libxlist.so: $(XLIST_OBJS) $(XLIST_DEPS)
	$(CC) -shared -o libxlist.so $(XLIST_OBJS)

reverse: $(REVERSE_OBJS) $(REVERSE_DEPS)
	$(CC) -o reverse $(REVERSE_OBJS) -L. -lxlist -llist

.PHONY: clean
clean:
	rm -f $(LIST_OBJS) $(XLIST_OBJS) $(REVERSE_OBJS) liblist.a liblist.so libxlist.a libxlist.so reverse

