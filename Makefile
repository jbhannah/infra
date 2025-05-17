HOSTNAME := $(shell hostname -s)
ACTIONS := check switch

switch: check

.PHONY: $(ACTIONS)
$(ACTIONS):
	darwin-rebuild $@ --flake .#$(HOSTNAME)
