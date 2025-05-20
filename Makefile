HOSTNAME := $(shell hostname -s)
ACTIONS := build
SUDO_ACTIONS := check switch

.PHONY: $(ACTIONS)
$(ACTIONS):
	darwin-rebuild $@ --flake .#$(HOSTNAME)

.PHONY: $(SUDO_ACTIONS)
$(SUDO_ACTIONS):
	sudo darwin-rebuild $@ --flake .#$(HOSTNAME)
