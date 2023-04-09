#!/usr/bin/env bash

git --version

echo "Teste interne struktur"
git fsck --full --no-dangling

echo "Entpacke alle blobs"
echo ""
mkdir scan-tmp
for object in $(git cat-file --batch-all-objects --batch-check='%(objectname) %(objecttype)' | grep blob | cut -d" " -f1,3-); do
  echo -ne "Entpacke blob: $object\033[0K\r"
  git cat-file -p $object > scan-tmp/$object.blob
done
echo ""

echo "Teste alle blobs"

clamscan --suppress-ok-results --archive-verbose --log=scan.log --recursive scan-tmp/

rm -r scan-tmp