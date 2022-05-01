#!/usr/bin/env bash

set -x

REGEX='^v([0-9]{1,}\.){2}[0-9]{1,}$'
DEFAULT_BRANCH=$(git remote show origin | grep 'HEAD branch' | cut -d' ' -f5)
LATEST_VERSION=$(git describe --tags --always | egrep "${REGEX}")
LATEST_GIT_TAG_SHORT_HASH=$(git rev-list -n 1 $(git describe --tags --always | egrep "${REGEX}") --abbrev-commit 2>/dev/null)

if [ "${LATEST_GIT_TAG_SHORT_HASH}" = "$(git rev-list HEAD --abbrev-commit)" ];
then
  NEXT_GIT_TAG=${LATEST_VERSION}
else
  NEXT_GIT_TAG=$(semtag final -s minor -o)
fi

changelog() {
  git-chglog -o CHANGELOG.md --next-tag ${NEXT_GIT_TAG}
}

delete-release() {
	git tag --delete ${LATEST_VERSION} 2>/dev/null
	git branch -D release/${LATEST_VERSION} 2>/dev/null
}

delete-release-from-remote() {
	git push origin tag --delete ${NEXT_GIT_TAG} 2>/dev/null
	git push origin branch --delete release/${NEXT_GIT_TAG} 2>/dev/null
}

release() {
	echo "git tag ${NEXT_GIT_TAG} -a -m 'Created ${NEXT_GIT_TAG}' 2>/dev/null"
	echo "git branch release/${NEXT_GIT_TAG} 2>/dev/null"
}

publish-release() {
	echo "git push origin ${LATEST_VERSION} 2>/dev/null"
	echo "git push origin release/${LATEST_VERSION} 2>/dev/null"
	echo "gh release create ${LATEST_VERSION} --generate-notes"
}

latest() {
  echo "${LATEST_VERSION}"
}

next-version() {
  echo "${NEXT_GIT_TAG}"
}

main() {
  latest
  next-version
  release
  publish-release
}

main
