# Makefile to build and test the root Xcode project (no workspace) with colors,
# SwiftFormat + SwiftLint (with autocorrect), and coverage gating.
#
# Defaults:
#   XC_PROJECT   = Bookify.xcodeproj
#   XC_SCHEME    = Bookify
#   XC_DEST      = platform=iOS Simulator,name=iPhone 15,OS=latest  (overridden dynamically if not set)
#   COVERAGE_MIN = 80
#
# Usage:
#   make setup
#   make build                # format + lint (autocorrect) + xcodebuild clean build
#   make test                 # format + lint + xcodebuild test + coverage gate
#   make test COVERAGE_MIN=85 # override coverage threshold
#   make feature              # interactive feature scaffolder
#
# Notes:
# - You can override project/scheme/destination:
#     make build XC_PROJECT=Bookify.xcodeproj XC_SCHEME=Bookify XC_DEST="platform=iOS Simulator,name=iPhone 17,OS=latest"
# - Optional SPM helpers (for real Swift packages like DevTookKit) are included at the bottom:
#     make spm-build PKG_DIR=Packages/DevTookKit
#     make spm-test  PKG_DIR=Packages/DevTookKit
#
# Dynamic simulator resolution:
# - If XC_DEST is not provided, the Makefile will:
#     • Use a booted simulator if available.
#     • Else find the latest iOS runtime and prefer a common iPhone model.
#     • Boot it if needed and pass -destination 'id=<UDID>' to xcodebuild.

SHELL := /bin/bash

# Xcode project configuration (override on invocation if needed)
XC_PROJECT   ?= Bookify.xcodeproj
XC_SCHEME    ?= Bookify
# Default destination (will be overridden by _resolve-sim unless user provided XC_DEST)
XC_DEST      ?= platform=iOS Simulator,name=iPhone 15,OS=latest

# Coverage threshold for xcodebuild test (via xccov)
COVERAGE_MIN ?= 80

# Prefer Homebrew/Xcode toolchain on Apple Silicon & Intel
PATH := /opt/homebrew/bin:/usr/local/bin:$(PATH)

# ANSI colors
COLOR_RED    := \033[0;31m
COLOR_YELLOW := \033[0;33m
COLOR_BLUE   := \033[0;34m
COLOR_GREEN  := \033[0;32m
COLOR_RESET  := \033[0m

INFO  := printf "$(COLOR_BLUE)ℹ️  %s$(COLOR_RESET)\n"
WARN  := printf "$(COLOR_YELLOW)⚠️  %s$(COLOR_RESET)\n"
ERROR := printf "$(COLOR_RED)❌ %s$(COLOR_RESET)\n"
OK    := printf "$(COLOR_GREEN)✅ %s$(COLOR_RESET)\n"

.PHONY: setup build test clean-xcode format lint lint-fix check-swiftformat check-swiftlint _ensure-tools _coverage-xcode \
        spm-build spm-test spm-clean _spm-coverage _assert-pkgdir _resolve-sim feature

# New: interactive feature scaffolder (root-level script)
feature:
	@chmod +x ./new-feature.sh || true
	@if [ ! -f "./new-feature.sh" ]; then \
		$(WARN) "new-feature.sh not found in repo root."; \
		$(INFO) "Create a script at ./new-feature.sh and re-run 'make feature'."; \
		exit 0; \
	fi
	@./new-feature.sh

setup:
	@$(INFO) "Setup guidance:"
	@$(INFO) "• Run 'make check-swiftformat' to verify SwiftFormat is installed."
	@$(INFO) "• Run 'make check-swiftlint'   to verify SwiftLint is installed."
	@$(INFO) "• Use Homebrew to install missing tools, e.g.:"
	@$(INFO) "    brew install swiftformat swiftlint"
	@echo ""
	@$(INFO) "Xcode workflow:"
	@$(INFO) "• make build  # format + lint + xcodebuild clean build (project: $(XC_PROJECT), scheme: $(XC_SCHEME))"
	@$(INFO) "• make test   # format + lint + xcodebuild test + coverage gate ($(COVERAGE_MIN)% min)"
	@echo ""
	@$(INFO) "SPM helpers (for true Swift packages only):"
	@$(INFO) "• make spm-build PKG_DIR=Packages/DevTookKit"
	@$(INFO) "• make spm-test  PKG_DIR=Packages/DevTookKit"

check-swiftformat:
	@$(INFO) "Checking for swiftformat..."
	@if command -v swiftformat >/dev/null 2>&1; then \
		$(OK) "SwiftFormat: $$(which swiftformat)"; \
	else \
		$(ERROR) "SwiftFormat not found on PATH."; \
		$(WARN) "Try: brew install swiftformat"; \
		exit 1; \
	fi

check-swiftlint:
	@$(INFO) "Checking for swiftlint..."
	@if command -v swiftlint >/dev/null 2>&1; then \
		$(OK) "SwiftLint: $$(which swiftlint)"; \
	else \
		$(ERROR) "SwiftLint not found on PATH."; \
		$(WARN) "Try: brew install swiftlint"; \
		exit 1; \
	fi

# Auto-fix SwiftLint violations where possible before linting
lint-fix: check-swiftlint
	@$(INFO) "SwiftLint: attempting autocorrect..."
	@swiftlint autocorrect --format || { $(WARN) "SwiftLint autocorrect encountered issues (continuing)"; true; }
	@$(OK) "SwiftLint autocorrect done"

# Lint after attempting fixes, fail if violations remain
lint: lint-fix
	@$(INFO) "Running SwiftLint..."
	@swiftlint || { $(ERROR) "SwiftLint failed"; exit 1; }
	@$(OK) "SwiftLint completed"

format: check-swiftformat
	@$(INFO) "Running SwiftFormat..."
	@swiftformat . >/dev/null || { $(ERROR) "SwiftFormat failed"; exit 1; }
	@$(OK) "SwiftFormat completed"

# Resolve a simulator dynamically unless XC_DEST is already provided by the caller.
# Exports XC_DEST as "-destination 'id=<UDID>'" when resolved dynamically.
_resolve-sim:
	@if [[ -n "$${XC_DEST_SET:-}" ]]; then \
		$(INFO) "Using provided XC_DEST: $(XC_DEST)"; \
		exit 0; \
	fi; \
	if [[ -n "$(XC_DEST)" && "$(XC_DEST)" != "platform=iOS Simulator,name=iPhone 15,OS=latest" ]]; then \
		$(INFO) "XC_DEST explicitly set by user: $(XC_DEST)"; \
		export XC_DEST_SET=1; \
		exit 0; \
	fi; \
	set -euo pipefail; \
	$(INFO) "Resolving iOS Simulator dynamically..."; \
	if ! command -v xcrun >/dev/null 2>&1; then \
		$(ERROR) "xcrun not found. Install Xcode command line tools."; exit 1; \
	fi; \
	BOOTED_UDID=$$(xcrun simctl list devices booted | awk -F'[()]' '/Booted/{print $$2; exit}'); \
	if [[ -n "$$BOOTED_UDID" ]]; then \
		NAME=$$(xcrun simctl list devices | awk -v id="$$BOOTED_UDID" -F'[()]' '$$0 ~ id {print $$1; exit}'); \
		$(OK) "Using already booted simulator: $$NAME ($$BOOTED_UDID)"; \
		export XC_DEST="id=$$BOOTED_UDID"; \
		echo "XC_DEST=$$XC_DEST" > .xc_dest_env; \
		exit 0; \
	fi; \
	LATEST_RUNTIME=$$(xcrun simctl list runtimes | awk -F'[()]' '/iOS/ && $$0 ~ /Available/ {print $$2}' | sort -V | tail -n1); \
	if [[ -z "$$LATEST_RUNTIME" ]]; then \
		$(ERROR) "No available iOS Simulator runtime found."; exit 1; \
	fi; \
	$(INFO) "Latest iOS runtime: $$LATEST_RUNTIME"; \
	readarray -t PREFERRED < <(printf "%s\n" \
		"iPhone 17 Pro Max" "iPhone 17 Pro" "iPhone 17" "iPhone 16e" "iPhone Air" \
		"iPhone 16 Pro Max" "iPhone 16 Pro" "iPhone 16 Plus" "iPhone 16" \
		"iPhone 15 Pro Max" "iPhone 15 Pro" "iPhone 15 Plus" "iPhone 15" \
		"iPhone SE (3rd generation)"); \
	CHOSEN_ID=""; \
	for NAME in "$${PREFERRED[@]}"; do \
		ID=$$(xcrun simctl list devices "iOS $$LATEST_RUNTIME" | awk -v n="$$NAME" -F'[()]' -v OFS="" '$$0 ~ n && $$0 ~ /Available/ {print $$2; exit}'); \
		if [[ -n "$$ID" ]]; then CHOSEN_ID="$$ID"; CHOSEN_NAME="$$NAME"; break; fi; \
	done; \
	if [[ -z "$$CHOSEN_ID" ]]; then \
		CHOSEN_ID=$$(xcrun simctl list devices "iOS $$LATEST_RUNTIME" | awk -F'[()]' '/iPhone/ && $$0 ~ /Available/ {print $$2; exit}'); \
		CHOSEN_NAME=$$(xcrun simctl list devices | awk -v id="$$CHOSEN_ID" -F'[()]' '$$0 ~ id {print $$1; exit}'); \
	fi; \
	if [[ -z "$$CHOSEN_ID" ]]; then \
		$(ERROR) "No suitable iPhone simulator found for iOS $$LATEST_RUNTIME."; exit 1; \
	fi; \
	$(INFO) "Selected simulator: $$CHOSEN_NAME ($$CHOSEN_ID)"; \
	STATE=$$(xcrun simctl list devices | awk -v id="$$CHOSEN_ID" -F'[()]' '$$0 ~ id {print $$0}' | sed -E 's/.*- (.*)$$/\1/'); \
	if [[ "$$STATE" != "Booted" ]]; then \
		$(INFO) "Booting simulator $$CHOSEN_NAME..."; \
		xcrun simctl boot "$$CHOSEN_ID" >/dev/null || true; \
		open -g -a Simulator || true; \
		sleep 5; \
	fi; \
	export XC_DEST="id=$$CHOSEN_ID"; \
	echo "XC_DEST=$$XC_DEST" > .xc_dest_env; \
	$(OK) "Destination resolved: $$XC_DEST"

-include .xc_dest_env

clean-xcode:
	@$(INFO) "Cleaning Xcode build (project: $(XC_PROJECT), scheme: $(XC_SCHEME))..."
	@xcodebuild -project "$(XC_PROJECT)" -scheme "$(XC_SCHEME)" clean | xcpretty || true
	@$(OK) "Xcode clean completed"

build: _ensure-tools format lint _resolve-sim clean-xcode
	@$(INFO) "Building Xcode project '$(XC_PROJECT)' (scheme: '$(XC_SCHEME)')..."
	@set -euo pipefail; \
	if command -v xcpretty >/dev/null 2>&1; then \
		if [[ "$(XC_DEST)" == id=* ]]; then \
			xcodebuild -project "$(XC_PROJECT)" -scheme "$(XC_SCHEME)" -configuration Debug -destination '$(XC_DEST)' build | xcpretty && exit $${PIPESTATUS[0]}; \
		else \
			xcodebuild -project "$(XC_PROJECT)" -scheme "$(XC_SCHEME)" -configuration Debug build | xcpretty && exit $${PIPESTATUS[0]}; \
		fi; \
	else \
		if [[ "$(XC_DEST)" == id=* ]]; then \
			xcodebuild -project "$(XC_PROJECT)" -scheme "$(XC_SCHEME)" -configuration Debug -destination '$(XC_DEST)' build; \
		else \
			xcodebuild -project "$(XC_PROJECT)" -scheme "$(XC_SCHEME)" -configuration Debug build; \
		fi; \
	fi
	@$(OK) "Build succeeded"

test: _ensure-tools format lint _resolve-sim clean-xcode
	@$(INFO) "Testing Xcode project '$(XC_PROJECT)' (scheme: '$(XC_SCHEME)') with coverage..."
	@set -euo pipefail; \
	DERIVED=$$(mktemp -d "$${TMPDIR%/}/BookifyDerivedData.XXXXXX"); \
	if command -v xcpretty >/dev/null 2>&1; then \
		if [[ "$(XC_DEST)" == id=* ]]; then \
			xcodebuild -project "$(XC_PROJECT)" -scheme "$(XC_SCHEME)" -destination '$(XC_DEST)' -enableCodeCoverage YES test -derivedDataPath "$$DERIVED" | xcpretty && STATUS=$${PIPESTATUS[0]}; \
		else \
			xcodebuild -project "$(XC_PROJECT)" -scheme "$(XC_SCHEME)" -destination '$(XC_DEST)' -enableCodeCoverage YES test -derivedDataPath "$$DERIVED" | xcpretty && STATUS=$${PIPESTATUS[0]}; \
		fi; \
	else \
		if [[ "$(XC_DEST)" == id=* ]]; then \
			xcodebuild -project "$(XC_PROJECT)" -scheme "$(XC_SCHEME)" -destination '$(XC_DEST)' -enableCodeCoverage YES test -derivedDataPath "$$DERIVED"; STATUS=$$?; \
		else \
			xcodebuild -project "$(XC_PROJECT)" -scheme "$(XC_SCHEME)" -destination '$(XC_DEST)' -enableCodeCoverage YES test -derivedDataPath "$$DERIVED"; STATUS=$$?; \
		fi; \
	fi; \
	if [ "$$STATUS" -ne 0 ]; then $(ERROR) "xcodebuild test failed"; exit $$STATUS; fi; \
	$(MAKE) _coverage-xcode DERIVED_DATA="$$DERIVED" COVERAGE_MIN=$(COVERAGE_MIN)

_coverage-xcode:
	@set -euo pipefail; \
	$(INFO) "Computing Xcode coverage (min $(COVERAGE_MIN)%)..."; \
	if ! command -v xcrun >/dev/null 2>&1; then $(ERROR) "xcrun not found. Install Xcode command line tools."; exit 1; fi; \
	XCCOV=$$(xcrun --find xccov); \
	if [ ! -x "$$XCCOV" ]; then $(ERROR) "xccov not found via xcrun."; exit 1; fi; \
	PROF=$$(find "$(DERIVED_DATA)/Logs/Test" -name "*.xcresult" -type f -print0 | xargs -0 ls -t | head -n1); \
	if [ -z "$$PROF" ]; then $(ERROR) "No .xcresult found in DerivedData logs. It appears no tests ran. Failing in strict mode."; exit 1; fi; \
	PCT=$$("$${XCCOV}" view --report --json "$$PROF" | /usr/bin/python3 -c 'import sys,json; d=json.load(sys.stdin); print(d.get("lineCoverage",0.0)*100.0)'); \
	printf "$(COLOR_BLUE)ℹ️  Coverage total: %.2f%%$(COLOR_RESET) (min %s%%)\n" "$$PCT" "$(COVERAGE_MIN)"; \
	awk -v pct="$$PCT" -v min="$(COVERAGE_MIN)" 'BEGIN { if (pct+0 < min+0) exit 1 }' || { $(ERROR) "Coverage gate failed: $$PCT% < $(COVERAGE_MIN)%"; exit 1; }; \
	$(OK) "Coverage gate passed"

_ensure-tools: check-swiftformat check-swiftlint

PKG_DIR ?= .

spm-clean: _assert-pkgdir
	@$(INFO) "Cleaning Swift Package in '$(PKG_DIR)'..."
	@(cd "$(PKG_DIR)" && swift package clean) || { $(ERROR) "swift package clean failed in $(PKG_DIR)"; exit 1; }
	@$(OK) "SPM clean completed"

spm-build: _assert-pkgdir
	@$(INFO) "SPM build in '$(PKG_DIR)'..."
	@(cd "$(PKG_DIR)" && swift build) || { $(ERROR) "swift build failed"; exit 1; }
	@$(OK) "SPM build succeeded"

spm-test: _assert-pkgdir
	@$(INFO) "SPM test with coverage in '$(PKG_DIR)'..."
	@set -euo pipefail; \
	(cd "$(PKG_DIR)" && swift test --enable-code-coverage) || { exit 1; }; \
	$(MAKE) _spm-coverage PKG_DIR="$(PKG_DIR)" COVERAGE_MIN=$(COVERAGE_MIN)

_spm-coverage:
	@set -euo pipefail; \
	$(INFO) "Computing SPM coverage (min $(COVERAGE_MIN)%)..."; \
	if ! command -v xcrun >/dev/null 2>&1; then $(ERROR) "xcrun not found. Install Xcode command line tools."; exit 1; fi; \
	LLVM_COV=$$(xcrun --find llvm-cov); \
	PROFDATA=$$(find "$(PKG_DIR)/.build" -name default.profdata -print0 | xargs -0 ls -t | head -n1); \
	if [ -z "$$PROFDATA" ]; then $(ERROR) "SPM .profdata not found in $(PKG_DIR)/.build"; exit 1; fi; \
	TRIPLE_DIR=$$(find "$(PKG_DIR)/.build" -maxdepth 1 -type d -name "*-apple-*" -or -name "*-unknown-*" | head -n1); \
	[ -z "$$TRIPLE_DIR" ] && TRIPLE_DIR="$(PKG_DIR)/.build"; \
	BIN_DIR="$$TRIPLE_DIR/debug"; \
	mapfile -t BINARIES < <(find "$$BIN_DIR" -type f \( -perm +111 -o -name "*.xctest" -o -name "*.dylib" -o -name "*.framework" \) 2>/dev/null); \
	COV_OUTPUT=$$("$${LLVM_COV}" report -instr-profile "$$PROFDATA" $${BINARIES[@]} 2>/dev/null || true); \
	PCT=$$(echo "$$COV_OUTPUT" | awk '/^\s*TOTAL/ && $$0 ~ /%/ { for (i=1;i<=NF;i++) if ($$i ~ /%$$/) { gsub("%","",$$i); print $$i; exit } }'); \
	printf "$(COLOR_BLUE)ℹ️  SPM coverage total: %.2f%%$(COLOR_RESET) (min %s%%)\n" "$$PCT" "$(COVERAGE_MIN)"; \
	awk -v pct="$$PCT" -v min="$(COVERAGE_MIN)" 'BEGIN { if (pct+0 < min+0) exit 1 }' || { $(ERROR) "SPM coverage gate failed: $$PCT% < $(COVERAGE_MIN)%"; exit 1; }; \
	$(OK) "SPM coverage gate passed"

_assert-pkgdir:
	@if [ ! -f "$(PKG_DIR)/Package.swift" ]; then \
		$(ERROR) "Package.swift not found in '$(PKG_DIR)'. Set PKG_DIR to a Swift package folder."; \
		exit 1; \
	fi
