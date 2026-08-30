.PHONY: help setup check lint fmt fmt-check test preview build docs \
        chrome chrome-package vscode-package vscode-publish-vsce \
        vscode-publish-ovsx vscode-publish clean ci

# SilkCircuit Neon palette (see STYLE_GUIDE.md)
PURPLE := \033[38;2;225;53;255m
PINK   := \033[38;2;255;0;255m
CYAN   := \033[38;2;128;255;234m
GREEN  := \033[38;2;80;250;123m
YELLOW := \033[38;2;241;250;140m
BLUE   := \033[38;2;130;170;255m
CORAL  := \033[38;2;255;106;193m
GRAY   := \033[38;2;99;119;119m
WHITE  := \033[38;2;248;248;242m
RESET  := \033[0m
BOLD   := \033[1m

CHECK := ✓
CROSS := ✗
ARROW := ▸
DOT   := •
STAR  := ★
WARN  := !

# Run tooling through mise when it is available so everyone gets the pinned
# versions from mise.toml. Falls back to whatever is on PATH.
MISE := $(shell command -v mise 2>/dev/null)
X    := $(if $(MISE),mise x --,)

# Read the extension version from the manifest instead of hardcoding it.
VSCODE_VERSION = $(shell $(X) node -p "require('./extras/vscode/package.json').version" 2>/dev/null || echo "?")

# make preview VARIANT=glow
VARIANT ?= neon

define banner
	@printf "\n$(PURPLE)$(ARROW)$(RESET) $(PINK)$(BOLD)$(1)$(RESET)\n\n"
endef

help:
	@printf "\n"
	@printf "  $(PURPLE)$(BOLD)SilkCircuit$(RESET) $(GRAY)$(DOT)$(RESET) $(CYAN)Development Commands$(RESET)\n"
	@printf "  $(GRAY)────────────────────────────────────────────────$(RESET)\n\n"
	@printf "  $(WHITE)$(BOLD)Everyday$(RESET)\n"
	@printf "    $(PURPLE)$(STAR) setup$(RESET)           $(GRAY)─$(RESET) Install the pinned toolchain and git hooks\n"
	@printf "    $(PURPLE)$(STAR) check$(RESET)           $(GRAY)─$(RESET) Lint, format check, and test $(GRAY)(what CI runs)$(RESET)\n"
	@printf "    $(PURPLE)$(STAR) test$(RESET)            $(GRAY)─$(RESET) Run the test suite $(GRAY)(FILTER=name)$(RESET)\n"
	@printf "    $(PURPLE)$(STAR) fmt$(RESET)             $(GRAY)─$(RESET) Format Lua, Python, JSON, YAML, and Markdown\n"
	@printf "    $(PURPLE)$(STAR) lint$(RESET)            $(GRAY)─$(RESET) Run selene and ruff\n"
	@printf "    $(PURPLE)$(STAR) preview$(RESET)         $(GRAY)─$(RESET) Open Neovim with the theme $(GRAY)(VARIANT=glow)$(RESET)\n\n"
	@printf "  $(WHITE)$(BOLD)Generate$(RESET)\n"
	@printf "    $(CYAN)$(STAR) build$(RESET)           $(GRAY)─$(RESET) Regenerate every extras/ target from the palette\n"
	@printf "    $(CYAN)$(STAR) docs$(RESET)            $(GRAY)─$(RESET) Regenerate the README tables\n"
	@printf "    $(CYAN)$(STAR) chrome$(RESET)          $(GRAY)─$(RESET) Generate the Chrome theme variants\n"
	@printf "    $(CYAN)$(STAR) chrome-package$(RESET)  $(GRAY)─$(RESET) Zip the Chrome themes for the Web Store\n\n"
	@printf "  $(WHITE)$(BOLD)Release$(RESET)\n"
	@printf "    $(CORAL)$(STAR) vscode-package$(RESET)  $(GRAY)─$(RESET) Build the VSIX $(GRAY)(v$(VSCODE_VERSION))$(RESET)\n"
	@printf "    $(CORAL)$(STAR) vscode-publish$(RESET)  $(GRAY)─$(RESET) Publish to Marketplace and Open VSX\n"
	@printf "    $(CORAL)$(STAR) clean$(RESET)           $(GRAY)─$(RESET) Remove build output\n\n"

# ── Everyday ────────────────────────────────────────────────────────────────

setup:
	$(call banner,Setting Up)
ifeq ($(MISE),)
	@printf "  $(YELLOW)$(WARN)$(RESET) $(WHITE)mise is not installed$(RESET)\n"
	@printf "    $(GRAY)brew install mise$(RESET)   $(GRAY)or$(RESET)   $(GRAY)curl https://mise.run | sh$(RESET)\n"
	@printf "    $(GRAY)Then re-run: make setup$(RESET)\n\n"
	@exit 1
else
	@printf "  $(CYAN)$(DOT)$(RESET) Installing the pinned toolchain...\n"
	@mise trust --quiet
	@mise install
	@printf "  $(GREEN)$(CHECK)$(RESET) Toolchain ready\n"
	@printf "  $(CYAN)$(DOT)$(RESET) Installing git hooks...\n"
	@$(X) pre-commit install >/dev/null
	@printf "  $(GREEN)$(CHECK)$(RESET) Git hooks installed\n"
	@printf "\n$(GREEN)$(STAR) Setup complete$(RESET) $(GRAY)─ try: make check$(RESET)\n\n"
endif

check: lint fmt-check test
	@printf "\n$(GREEN)$(STAR) Everything passed$(RESET)\n\n"

lint:
	$(call banner,Linting)
	@printf "  $(CYAN)$(DOT)$(RESET) selene $(GRAY)lua/ tests/$(RESET)\n"
	@$(X) selene lua/ tests/
	@printf "  $(CYAN)$(DOT)$(RESET) ruff $(GRAY)scripts/$(RESET)\n"
	@$(X) ruff check scripts/
	@printf "  $(GREEN)$(CHECK)$(RESET) Lint clean\n\n"

fmt:
	$(call banner,Formatting)
	@printf "  $(CYAN)$(DOT)$(RESET) stylua $(GRAY)lua/ colors/ tests/ init.lua$(RESET)\n"
	@$(X) stylua lua/ colors/ tests/
	@printf "  $(CYAN)$(DOT)$(RESET) ruff format $(GRAY)scripts/$(RESET)\n"
	@$(X) ruff format --quiet scripts/
	@printf "  $(CYAN)$(DOT)$(RESET) prettier $(GRAY)json, yaml, markdown$(RESET)\n"
	@$(X) prettier --write --log-level warn "**/*.{json,jsonc,yaml,yml,md}"
	@printf "  $(GREEN)$(CHECK)$(RESET) Formatted\n\n"

fmt-check:
	$(call banner,Checking Formatting)
	@printf "  $(CYAN)$(DOT)$(RESET) stylua $(GRAY)lua/ colors/ tests/ init.lua$(RESET)\n"
	@$(X) stylua --check lua/ colors/ tests/
	@printf "  $(CYAN)$(DOT)$(RESET) ruff format $(GRAY)scripts/$(RESET)\n"
	@$(X) ruff format --check --quiet scripts/
	@printf "  $(CYAN)$(DOT)$(RESET) prettier $(GRAY)json, yaml, markdown$(RESET)\n"
	@$(X) prettier --check --log-level warn "**/*.{json,jsonc,yaml,yml,md}"
	@printf "  $(GREEN)$(CHECK)$(RESET) Formatting clean $(GRAY)─ run 'make fmt' to fix$(RESET)\n\n"

test:
	$(call banner,Running Tests)
	@if [ -x scripts/test ]; then \
		scripts/test $(if $(FILTER),--filter "$(FILTER)",); \
	else \
		printf "  $(YELLOW)$(WARN)$(RESET) $(WHITE)scripts/test not found, using the legacy runner$(RESET)\n\n"; \
		$(X) nvim --headless -u NONE -c "luafile tests/run.lua"; \
	fi

preview:
	$(call banner,Previewing $(VARIANT))
	@if [ ! -f tests/minimal_init.lua ]; then \
		printf "  $(YELLOW)$(WARN)$(RESET) $(WHITE)tests/minimal_init.lua not found$(RESET)\n\n"; \
		exit 1; \
	fi
	@$(X) nvim --clean -u tests/minimal_init.lua \
		-c "lua require('silkcircuit').setup({ variant = '$(VARIANT)' })" \
		-c "colorscheme silkcircuit" \
		lua/silkcircuit/variants.lua

# ── Generate ────────────────────────────────────────────────────────────────

build:
	$(call banner,Building Extras)
	@scripts/build
	@printf "  $(GREEN)$(CHECK)$(RESET) Rendered from $(GRAY)lua/silkcircuit/variants.lua$(RESET)\n\n"

docs:
	$(call banner,Building Docs Tables)
	@scripts/docs
	@printf "  $(GREEN)$(CHECK)$(RESET) Extras tables refreshed\n\n"

chrome:
	$(call banner,Generating Chrome Themes)
	@printf "  $(CYAN)$(DOT)$(RESET) Rendering all 5 variants...\n"
	@$(X) uv run scripts/generate_chrome_themes.py
	@printf "  $(CYAN)$(DOT)$(RESET) Formatting generated manifests...\n"
	@$(X) prettier --write --log-level warn "extras/chrome-theme/**/*.json"
	@printf "  $(GREEN)$(CHECK)$(RESET) Written to $(GRAY)extras/chrome-theme/silkcircuit-*/$(RESET)\n\n"
	@printf "  $(CYAN)$(STAR) Load in Chrome:$(RESET) $(GRAY)chrome://extensions → Developer mode → Load unpacked$(RESET)\n\n"

chrome-package:
	$(call banner,Packaging Chrome Themes)
	@for variant in neon vibrant soft glow dawn; do \
		(cd extras/chrome-theme && \
			zip -qr "../../silkcircuit-chrome-$$variant.zip" "silkcircuit-$$variant/" -x "*.DS_Store") && \
		printf "  $(GREEN)$(CHECK)$(RESET) silkcircuit-chrome-$$variant.zip\n"; \
	done
	@printf "\n  $(CYAN)$(STAR) Upload:$(RESET) $(GRAY)https://chrome.google.com/webstore/devconsole$(RESET)\n\n"

# ── Release ─────────────────────────────────────────────────────────────────

vscode-package:
	$(call banner,Packaging VS Code Extension)
	@cd extras/vscode && $(X) npx @vscode/vsce package --no-dependencies | cat
	@printf "  $(GREEN)$(CHECK)$(RESET) $(GRAY)extras/vscode/silkcircuit-theme-$(VSCODE_VERSION).vsix$(RESET)\n\n"

vscode-publish-vsce:
	$(call banner,Publishing to VS Code Marketplace)
	@cd extras/vscode && $(X) npx @vscode/vsce publish --no-dependencies | cat
	@printf "  $(GREEN)$(CHECK)$(RESET) Published v$(VSCODE_VERSION) to the VS Code Marketplace\n\n"

vscode-publish-ovsx:
	$(call banner,Publishing to Open VSX)
	@cd extras/vscode && $(X) npx ovsx publish | cat
	@printf "  $(GREEN)$(CHECK)$(RESET) Published v$(VSCODE_VERSION) to Open VSX\n\n"

vscode-publish: vscode-publish-vsce vscode-publish-ovsx
	@printf "$(GREEN)$(STAR) v$(VSCODE_VERSION) is live on both marketplaces$(RESET)\n\n"

clean:
	$(call banner,Cleaning)
	@rm -rf cache/ docs/.vitepress/dist docs/.vitepress/cache
	@rm -f extras/vscode/*.vsix silkcircuit-chrome-*.zip
	@printf "  $(GREEN)$(CHECK)$(RESET) Build output removed\n\n"

ci: check
