HOSTNAME := $(shell hostname -s)
ACTIONS := check switch

switch: check

.PHONY: $(ACTIONS)
$(ACTIONS):
	sudo darwin-rebuild $@ --flake .#$(HOSTNAME)
