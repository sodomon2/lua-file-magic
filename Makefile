LUA     = 5.2
PREFIX  = /usr/local
LIBDIR  = $(PREFIX)/lib/lua/$(LUA)

VERSION = 0.2
GIT_REV		:= $(shell test -d .git && git describe || echo exported)
ifneq ($(GIT_REV), exported)
FULL_VERSION    := $(GIT_REV)
FULL_VERSION    := $(patsubst v%,%,$(FULL_VERSION))
else
FULL_VERSION    := $(VERSION)
endif

LUA_CFLAGS  = $(shell pkg-config --cflags lua$(LUA))
CFLAGS  = -O2 -fPIC $(LUA_CFLAGS) -DMODULE_VERSION=\"$(FULL_VERSION)\"
LIBS    = -lmagic $(shell pkg-config --libs lua$(LUA))

magic.so: magic.o
	$(CC) $(CFLAGS) -shared -o $@ magic.o $(LIBS)

clean:
	rm -rf *.o *.so

install: magic.so
	install -m 755 magic.so $(DESTDIR)$(LIBDIR)/
 
uninstall:
	rm -rf $(DESTDIR)$(LIBDIR)/magic.so

.PHONY: magic.so