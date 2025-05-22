#!/bin/bash

echo "running aclocal ..."
aclocal -I m4
echo "running autoheader ..."
autoheader
echo "running libtoolize ..."
libtoolize --automake --copy
echo "running automake ..."
automake --add-missing --copy --gnu
echo "running autoconf ..."
autoconf
