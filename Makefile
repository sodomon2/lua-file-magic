LUA     = 5.1
PREFIX  = /usr/local
LIBDIR  = $(PREFIX)/lib/lua/$(LUA)

LUA_CFLAGS  = $(shell pkg-config --cflags lua$(LUA))
CFLAGS  = -O2 -fPIC $(LUA_CFLAGS) -DMODULE_VERSION=\"0.2\"
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