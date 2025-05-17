HOSTNAME := $(shell hostname -s)
ACTIONS := check switch

.PHONY: $(ACTIONS)
$(ACTIONS):
	sudo darwin-rebuild $@ --flake .#$(HOSTNAME)
