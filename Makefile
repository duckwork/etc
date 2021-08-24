# ~/etc/ Makefile

BOOTSTRAPS:=$(wildcard bootstrap/*)
BOOTSTRAPS_OUT:=$(foreach b,$(BOOTSTRAPS),$(patsubst bootstrap/%,~/.%,$(b)))

.PHONY: bootstrap
bootstrap: $(BOOTSTRAPS_OUT)

~/.%: bootstrap/%
	ln -sf etc/$< $@
