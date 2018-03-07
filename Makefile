.SUFFIXES:

.PHONY: all check clean dist distclean doc install uninstall

PREFIX ?= $(HOME)/.local
dest = $(DESTDIR)$(PREFIX)
bindir = $(dest)/bin
mandir = $(dest)/share/man/man1
bin = git-mr-to
manpage = doc/$(bin).1

ASCIIDOC ?= asciidoctor

all: doc

doc: $(manpage)

%.1: %.1.adoc
	$(ASCIIDOC) --backend manpage --doctype manpage $<
	test -f $@
	@# Clean dangling em-dash semicolons.
	@# asciidoctor/asciidoctor#2604
	@sed -i 's|\(\\(em\);|\1|g' $@

install: $(manpage)
	install -d $(bindir) $(mandir)
	install -m 0775 $(bin) $(bindir)
	install -m 0644 $(manpage) $(mandir)

uninstall:
	$(RM) $(bindir)/$(bin)
	$(RM) $(mandir)/$(manpage)

check:
	shellcheck $(bin)
	shellcheck --shell sh completion.sh

clean:
	$(RM) $(manpage)

DIST_VERSION ?= $(shell git describe --always)
dist_name = git-mr-to-$(DIST_VERSION)
dist_tar_name = $(dist_name).tar
dist: $(dist_tar_name).gz

$(dist_tar_name).gz: $(manpage)
	git archive --format=tar \
	    --prefix=$(dist_name)/ $(DIST_VERSION)^{tree} \
	    > $(dist_tar_name)

	@mkdir -p $(dist_name)/doc
	@cp $(manpage) $(dist_name)/doc

	tar rf $(dist_tar_name) $(dist_name)
	@$(RM) -r $(dist_name)
	gzip -f -9 $(dist_tar_name)

distclean:
	$(RM) $(dist_tar_name)*
