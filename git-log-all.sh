#!/usr/bin/env bash

for gitDir in $(find . -type d | grep "\.git\$"); do
  echo "## Prüfe $gitDir"

  git -C $gitDir log --all --date-order --graph --pretty=short

  echo ""
  echo ""
done