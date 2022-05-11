SHELL=/bin/bash

.PHONY: changelog release

REGEX := ^v([0-9]{1,}\.){2}[0-9]{1,}$$
DEFAULT_BRANCH := $(shell git remote show origin | grep 'HEAD branch' | cut -d' ' -f5)
LATEST_VERSION := $(shell git --no-pager tag --sort=committerdate | grep -E '^v[0-9]' | sort -V | tail -1 2>/dev/null)
LATEST_GIT_TAG_SHORT_HASH := $(shell git rev-list -n 1 ${LATEST_VERSION} --abbrev-commit 2>/dev/null)

ifeq ($(LATEST_GIT_TAG_SHORT_HASH), $(shell git rev-parse --short HEAD))
  NEXT_GIT_TAG:=$(LATEST_VERSION)
else
  NEXT_GIT_TAG:=$(shell semtag final -s minor -o)
endif

changelog:
	git-chglog -o CHANGELOG.md --next-tag ${NEXT_GIT_TAG}

release:
	@echo "Release/Tag: ${NEXT_GIT_TAG}"
	@echo $(shell git tag ${NEXT_GIT_TAG} -a -m 'Created ${NEXT_GIT_TAG}' 2>/dev/null)
	@echo $(shell git branch release/${NEXT_GIT_TAG} 2>/dev/null)

publish-release:
	@echo $(shell git push origin $(LATEST_VERSION) 2>/dev/null)
	@echo $(shell git push origin release/$(LATEST_VERSION) 2>/dev/null)
	@echo $(shell gh release create $(LATEST_VERSION) --generate-notes 2>/dev/null)

latest:
	@echo "${LATEST_VERSION}"

latest-git-short-hash:
	@echo "${LATEST_GIT_TAG_SHORT_HASH}"

next-version:
	@echo $(shell semtag final -s minor -o)
