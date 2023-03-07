#!/bin/bash
set -e

JDK_PATH=
FIJI_PATH=

if [ $# -ge 1 ]; then
    FIJI_PATH=$1
fi
if [ $# -ge 2 ]; then
    JDK_PATH=$2
fi

mkdir -p build
mkdir -p dist
${JDK_PATH}javac -encoding utf8 -cp ${FIJI_PATH}jars/ij-1.*.jar -d build Slices_Div.java
cd build
${JDK_PATH}jar cvf ../dist/Slices_Div.jar ../plugins.config Slices_Div*.class
cd ..

if [ "$3" = "run" ]; then
	cp -f dist/Slices_Div.jar ${FIJI_PATH}plugins/
	kill $(xprop -name "(Fiji Is Just) ImageJ" _NET_WM_PID) || echo "OK"
	sleep 1
	gnome-terminal --title=FijiTerm -- ${FIJI_PATH}ImageJ-linux64 test.tif &
	sleep 1
fi
