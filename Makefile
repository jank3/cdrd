program = cdrd

src = $(program) \
      $(program).conf \
      $(program).conf.default \
      $(program).1 \
      Makefile README FAQ LICENSE

prefix = /usr/local


scriptdir = $(prefix)/bin
confdir   = $(prefix)/etc
mandir    = $(prefix)/man/man1
piddir    = /var/run/$(program)

INSTALL = /usr/bin/install -c

install:
    $(INSTALL) -d -m 0755 $(DESTDIR)$(scriptdir) $(DESTDIR)$(confdir) || exit 1;
    $(INSTALL) -o uucp -g dialer -m 0755 -d $(DESTDIR)$(piddir) || exit 1;
    $(INSTALL) -m 0755 $(program) $(DESTDIR)$(scriptdir)/$(program) || exit 1;
    $(INSTALL) -m 0644 $(program).conf $(DESTDIR)$(confdir)/$(program).conf || exit 1;
    $(INSTALL) -m 0644 $(program).1 $(DESTDIR)$(mandir)/$(program).1 || exit 1;

uninstall:
    -rm $(DESTDIR)$(scriptdir)/$(program) $(DESTDIR)$(confdir)/$(program).conf \
            $(DESTDIR)$(mandir)/$(program).1

PKGDIR = /tmp/$(program)-package

release:
    ../../tools/build_from_modules $(program) >| $(program);
    groff -m mandoc -T ascii $(program).1 | ../../tools/man2html -t 'Man page: $(program)(1)' >| $(program).1.html;
    vers=`egrep 'Version[ ]*=' $(program) | sed "s/.*'\(.*\)';/\1/"` ; \
    echo Preparing version $$vers; \
    rel=$(program)-$$vers ; \
    $(INSTALL) -o 0 -g 0 -m 0755 -d $(PKGDIR)/$$rel ; \
    $(INSTALL) -o 0 -g 0 -m 0644 $(src) $(PKGDIR)/$$rel ; \
    cd $(PKGDIR) && \
        tar -czvf $${rel}.tgz --group=0 --owner=0 $${rel} ; \
    md5sum $${rel}.tgz  > $(PKGDIR)/$${rel}.tgz.md5 ; \
    chmod 644 $(PKGDIR)/$${rel}.tgz  $(PKGDIR)/$${rel}.tgz.md5 ; \
    cd $(PKGDIR) && rm -f $(program) $(program).tgz $(program).tgz.md5 ; \
    ln -s $${rel}     $(program) ; \
    ln -s $${rel}.tgz     $(program).tgz ; \
    ln -s $${rel}.tgz.md5 $(program).tgz.md5

program:
    ../../tools/build_from_modules $(program) >| $(program);
