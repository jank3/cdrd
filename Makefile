PROGRAM = cdrd

PREFIX ?= /usr/local

BINDIR ?= $(PREFIX)/bin
ETCDIR ?= $(PREFIX)/etc/$(PROGRAM)
MANDIR ?= $(PREFIX)/man/man1
PIDDIR ?= /var/run/$(PROGRAM)

.PHONY: all install uninstall

all:
	@echo "Nothing to build"

install:
	install -d $(DESTDIR)$(BINDIR) $(DESTDIR)$(ETCDIR) $(DESTDIR)$(MANDIR) || exit 1;
	install -o uucp -g dialer -d $(DESTDIR)$(PIDDIR) || exit 1;
	install $(PROGRAM) $(DESTDIR)$(BINDIR) || exit 1;
	install -m 0644 $(PROGRAM).conf $(PROGRAM).conf.default $(DESTDIR)$(ETCDIR) || exit 1;
	install -m 0644 $(PROGRAM).1 $(DESTDIR)$(MANDIR) || exit 1;

uninstall:
	-rm $(DESTDIR)$(BINDIR)/$(PROGRAM) \
	    $(DESTDIR)$(ETCDIR)/$(PROGRAM).conf \
	    $(DESTDIR)$(ETCDIR)/$(PROGRAM).conf.default \
            $(DESTDIR)$(MANDIR)/$(PROGRAM).1
