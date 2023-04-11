#!/usr/bin/env bash

for gitDir in $(find . -type d | grep "\.git\$"); do
  echo "## Prüfe $gitDir"

  git -C $gitDir --no-pager log --all --date-order --graph --pretty=short --decorate

  echo ""
  echo ""
done