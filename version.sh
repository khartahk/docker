#!/bin/bash

function git_init () {
   #git config user.name github-actions
   #git config user.email github-actions@github.com
   git config advice.detachedHead false
}

function get_latest_release_branch () {
   BRANCH_REGEX=${1:-'(?<=refs/heads/)(main|master)$'}
   echo $(git ls-remote origin | grep -Po "$BRANCH_REGEX" | sort -rV | head -n1)
}

function get_latest_tag () {
   if [[ ! "^(main|master)$" =~ "$1" ]]; then
      TAG_REGEX=${1:-'v?[0-9]*(\.[0-9]*)?(\.[0-9]*)?$'}
      if [[ "$TAG_REGEX" == "$1" ]]; then
         TAG_REGEX=".*${1}.*"
      fi
   else
      TAG_REGEX=".*"
   fi
   echo $(git describe --tags `git rev-list --tags --max-count=1` | grep -Po "$TAG_REGEX" | sort -rV | head -n1)
}

# Functions that can "compare" versions gt, le, lt, ge
function version_gt() { test "$(echo "$@" | tr " " "n" | sort -V | head -n 1)" == "$1"; }
function version_le() { test "$(echo "$@" | tr " " "n" | sort -V | head -n 1)" != "$1"; }
function version_lt() { test "$(echo "$@" | tr " " "n" | sort -rV | head -n 1)" != "$1"; }
function version_ge() { test "$(echo "$@" | tr " " "n" | sort -rV | head -n 1)" == "$1"; }
