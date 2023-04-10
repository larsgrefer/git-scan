#!/usr/bin/env bash

for gitDir in $(find . -type d | grep "\.git\$"); do
  echo "## Prüfe $gitDir"

  echo "$(git -C $gitDir cat-file --buffer --batch-all-objects --batch-check='%(objectname) %(objecttype)' | grep -c blob) blobs in $gitDir"
  echo ""
done