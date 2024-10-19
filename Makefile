#
# Makefile for Homemaker Sample
#

# Comment this out to enable installing in your home directory.
SAFE := 1


default: build


HOMEMAKER_CORE := homemaker-core
HOMEMAKER_CORE_GITHUB := https://github.com/markfeit/$(HOMEMAKER_CORE).git
$(HOMEMAKER_CORE):
	git clone "$(HOMEMAKER_CORE_GITHUB)"
TO_CLEAN += $(HOMEMAKER_CORE)

core-update:: $(HOMEMAKER_CORE)
	git -C "$(HOMEMAKER_CORE)" pull

core-update:: FORCE




HOMEMAKER_HOME := home
$(HOMEMAKER_HOME):
	@echo "No 'home' directory present."
	@false


WORK := work
$(WORK):: core-update $(HOMEMAKER_HOME)
	rm -rf "$@"
	mkdir -p "$@"
	(cd $(HOMEMAKER_CORE) && tar cf - .) | (cd "$@" && tar xpf -)
	rm -rf "$@/home"
	(tar cf - "$(HOMEMAKER_HOME)") | (cd "$@" && tar xpf -)
TO_CLEAN += $(WORK)

$(WORK):: FORCE



build:
	@echo "Nothing to do here."



ifdef SAFE
  SAFE_DEST := installed
  $(SAFE_DEST)::
	mkdir -p $(SAFE_DEST)
  TO_CLEAN += $(SAFE_DEST)

  $(SAFE_DEST):: FORCE

  DEST_OPT := 'DEST_DIR=$(realpath $(SAFE_DEST))'
endif

install: $(WORK) $(SAFE_DEST)
	$(MAKE) -C "$(WORK)" $(DEST_OPT) "$@"


clean:
	rm -rf $(TO_CLEAN)
	find . -name "*~" | xargs rm -rf


FORCE::
	@true
