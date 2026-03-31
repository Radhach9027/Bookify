# Makefile proxies to ./dev and scripts for convenience.
# Usage examples:
#   make setup           # optional bootstrap
#   make fmt lint test   # format, lint, test
#   make story-start K=HJ-123 T="Hotels: dashboard list" M=Hotels F=HotelsDashBoard
#   make pr K=HJ-123     # open PR
#   make done K=HJ-123   # complete story
#   make check-layout    # validate monolithic-modular structure

SHELL := /bin/bash

# Variables (override on command line: make story-start K=HJ-123 T="Title" M=Hotels F=Feature)
K ?=
T ?=
M ?=
F ?=

.PHONY: help setup fmt lint test story-start pr done check-layout archlint

help:
	@echo "Targets:"
	@echo "  setup            Install local tools (optional placeholders)"
	@echo "  fmt              Run SwiftFormat"
	@echo "  lint             Run SwiftLint"
	@echo "  test             Run Swift tests (parallel)"
	@echo "  story-start      Bootstrap a JIRA story (requires K, T, M, F)"
	@echo "  pr               Open a PR for story (requires K)"
	@echo "  done             Finish a story (requires K)"
	@echo "  check-layout     Validate repo structure"
	@echo "  archlint         Run architecture linter"

setup:
	@echo "Setup placeholder (install tools if needed)."
	@command -v swiftformat >/dev/null || echo "SwiftFormat not found. Install via Homebrew: brew install swiftformat"
	@command -v swiftlint >/dev/null || echo "SwiftLint not found. Install via Homebrew: brew install swiftlint"

fmt:
	./dev fmt

lint:
	./dev lint

test:
	./dev test

story-start:
	@if [ -z "$(K)" ] || [ -z "$(T)" ] || [ -z "$(M)" ] || [ -z "$(F)" ]; then \
		echo "Usage: make story-start K=<JIRAKEY> T=\"Title\" M=<Module> F=<Feature>"; exit 1; \
	fi
	./dev story start "$(K)" "$(T)" --module "$(M)" --feature "$(F)"

pr:
	@if [ -z "$(K)" ]; then echo "Usage: make pr K=<JIRAKEY>"; exit 1; fi
	./dev story pr "$(K)"

done:
	@if [ -z "$(K)" ]; then echo "Usage: make done K=<JIRAKEY>"; exit 1; fi
	./dev story done "$(K)"

check-layout:
	@swift Scripts/check-repo-layout.swift

archlint:
	@swift Scripts/archlint.swift
