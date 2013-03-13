#!/bin/sh

make clean
make html

# fix to make the offline search work properly
sed -i '/jQuery(func{ Search.loadIndex("searchindex.js"); });/d' build/html/search.html
sed -i '/jQuery(function() { Search.loadIndex("searchindex.js"); });/d' build/html/search.html
sed -i 's/<\/head>/<script type="text\/javascript" src="searchindex.js"><\/script><\/head>/g' build/html/search.html

# make the cd image
rm -rf -iso
mkdir iso
cd iso
cp -R ../build/html .
ln -s html/index.html start_here.html
cd ..
mkisofs -o ans_cd.iso -J -r -V ANS_student2013 iso

# for testing, mount it with:
#mkdir -p mnt
#sudo mount -t iso9660 -o ro,loop=/dev/loop0 ans_cd.iso mnt

# see (see: http://www.ibm.com/developerworks/library/l-cdburn/) for burning info
