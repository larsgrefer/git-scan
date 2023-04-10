#!/usr/bin/env bash

for gitDir in $(find . -type d | grep "\.git\$"); do
  echo "## Prüfe $gitDir"

  git -C $gitDir fsck --full --no-dangling --no-progress --strict
  echo ""
  echo ""
done