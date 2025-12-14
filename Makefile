SHELL:=/usr/bin/env sh

.DEFAULT_GOAL := help
PROJECT_NAME = "notes.nvim"
LUARC = $(shell readlink -f .luarc.json)

.PHONY: chores ## run linters and formaters
chores: style lint spell_checking


.PHONY: style
style:  ## Format code
	stylua --check .

lint: ## Lint code
	selene --config selene/config.toml lua/

spell_checking: # Language agnostic spell checking
	typos lua

.PHONY: style
types: ## Static type checking
	lua-language-server --configpath "$(LUARC)" --check lua/notes

.PHONY: help
help:  ## Display this help
	@echo "Welcome to $$(tput bold)${PROJECT_NAME}$$(tput sgr0) 🥳📈🎉"
	@echo ""
	@echo "To get started:"
	@echo "  >>> $$(tput bold)make chores$$(tput sgr0)"
	@awk 'BEGIN {FS = ":.*##"; printf "\033[36m\033[0m"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
