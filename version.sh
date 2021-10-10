#!/bin/bash

git config user.name github-actions
git config user.email github-actions@github.com
git config advice.detachedHead false

function version_gt() { test "$(echo "$@" | tr " " "n" | sort -V | head -n 1)" == "$1"; }
function version_le() { test "$(echo "$@" | tr " " "n" | sort -V | head -n 1)" != "$1"; }
function version_lt() { test "$(echo "$@" | tr " " "n" | sort -rV | head -n 1)" != "$1"; }
function version_ge() { test "$(echo "$@" | tr " " "n" | sort -rV | head -n 1)" == "$1"; }

function get_latest_release_branch () {
   BRANCH_REGEX=${1:-'(?<=refs/heads/)main$'}
   echo $(git ls-remote origin | grep -Po "$BRANCH_REGEX" | sort -rV | head -n1)
}

function get_latest_tag () {
   echo $(git describe --tags `git rev-list --tags --max-count=1` | grep "v$1" | sort -rV | head -n1)
}

function upstream_add () {
   git remote add upstream https://github.com/tailscale/tailscale.git
}

