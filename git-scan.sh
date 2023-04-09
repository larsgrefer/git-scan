#!/usr/bin/env bash

tmpDir=scan-tmp-dir

git --version

echo ""
echo "## Teste interne Integrität des Repositories"
git fsck --full --no-dangling

echo ""
echo "## Entpacke alle $(git cat-file --buffer --batch-all-objects --batch-check='%(objectname) %(objecttype)' | grep -c blob) Blobs nach $tmpDir"

for object in $(git cat-file --buffer --batch-all-objects --batch-check='%(objectname) %(objecttype)' | grep blob | cut -d" " -f1,3-); do
  echo -ne "Entpacke Blob: $object\033[0K\r"

  mkdir -p $tmpDir/"${object:0:2}"
  git cat-file -p $object > $tmpDir/"${object:0:2}"/"$object".blob
done
echo ""

echo ""
echo "## Teste alle Blobs mit ClamAV"

clamscan --suppress-ok-results --verbose --archive-verbose --log=scan.log --recursive $tmpDir

rm -r $tmpDir