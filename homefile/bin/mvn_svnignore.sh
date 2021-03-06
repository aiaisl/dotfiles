#!/bin/sh
function svn_ignore() {
    echo "process $1"
    #svn propget svn:ignore $1 | grep -v ^$ > svn_ignore.txt
    touch svn_ignore.txt
    for ignorable in '.settings' 'lib' 'dist' 'eclipse' '.project' '.classpath' 'target' '*.ipr' '*.iml' '.idea' '.git' '.gitignore' '.DS*'
    do
        grep "$ignorable" svn_ignore.txt
        if [ $? -ne 0 ] ; then echo "$ignorable" >> svn_ignore.txt ; fi
    done
    svn propset svn:ignore -F svn_ignore.txt $1
    rm -f svn_ignore.txt
}

ALL_POM=$(find `pwd` -name pom.xml)

for POM in $ALL_POM; do
  pomdir=`dirname $POM`
  svn_ignore $pomdir
done
