PROGRAM = cdrd

PREFIX ?= /usr/local

BINDIR ?= $(PREFIX)/bin
ETCDIR ?= $(PREFIX)/etc/$(PROGRAM)
MANDIR ?= $(PREFIX)/man/man1
PIDDIR ?= /var/run/$(PROGRAM)
LOGDIR ?= /var/log/$(PROGRAM)

.PHONY: all install uninstall

all:
	@echo "Nothing to build"

install:
	install -d $(DESTDIR)$(BINDIR) $(DESTDIR)$(ETCDIR) $(DESTDIR)$(MANDIR) || exit 1;
	install -o uucp -g dialer -d $(DESTDIR)$(LOGDIR) $(DESTDIR)$(PIDDIR) || exit 1;
	install $(PROGRAM) $(DESTDIR)$(BINDIR) || exit 1;
	install -m 0644 \
	    $(PROGRAM).conf.sample \
	    $(PROGRAM).conf.default \
	    $(PROGRAM).newsyslog.conf.sample \
	    $(DESTDIR)$(ETCDIR) || exit 1;
	install -m 0644 $(PROGRAM).1 $(DESTDIR)$(MANDIR) || exit 1;

uninstall:
	-rm $(DESTDIR)$(BINDIR)/$(PROGRAM) \
	    $(DESTDIR)$(ETCDIR)/$(PROGRAM).conf.sample \
	    $(DESTDIR)$(ETCDIR)/$(PROGRAM).conf.default \
	    $(DESTDIR)$(ETCDIR)/$(PROGRAM).newsyslog.conf.sample \
	    $(DESTDIR)$(MANDIR)/$(PROGRAM).1
