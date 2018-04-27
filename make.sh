#!/bin/bash
cd "$(dirname "$0")"
cd project-lemon
command -v qmake >/dev/null 2>&1 || { (brew tap cartr/qt4 && brew tap-pin cartr/qt4 && brew install qt@4) 2>&1 || { echo >&2 "Require brew but it's not installed.  Aborting."; exit 1; } }
command -v rpl >/dev/null 2>&1 || { brew install rpl; }
rpl "Q_OS_MAC" "Q_OS_MAC" ./*
rm -f watcher_unix
gcc -o watcher_unix watcher_unix.c
cp icon.png lemon.icns
echo >> lemon.pro
echo "ICON = lemon.icns" >> lemon.pro
qmake
make
echo "PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPCFET0NUWVBFIHBsaXN0IFBVQkxJQyAiLS8vQXBwbGUvL0RURCBQTElTVCAxLjAvL0VOIiAiaHR0cDovL3d3dy5hcHBsZS5jb20vRFREcy9Qcm9wZXJ0eUxpc3QtMS4wLmR0ZCI+CjxwbGlzdCB2ZXJzaW9uPSIxLjAiPgo8ZGljdD4KCTxrZXk+Q0ZCdW5kbGVFeGVjdXRhYmxlPC9rZXk+Cgk8c3RyaW5nPmxlbW9uPC9zdHJpbmc+Cgk8a2V5PkNGQnVuZGxlR2V0SW5mb1N0cmluZzwva2V5PgoJPHN0cmluZz5MZW1vbiwg566A5piTT0nnq57otZvmtYvor5Xnjq/looM8L3N0cmluZz4KCTxrZXk+Q0ZCdW5kbGVJY29uRmlsZTwva2V5PgoJPHN0cmluZz5sZW1vbjwvc3RyaW5nPgoJPGtleT5DRkJ1bmRsZUlkZW50aWZpZXI8L2tleT4KCTxzdHJpbmc+b3JnLmx5b2kubGVtb248L3N0cmluZz4KCTxrZXk+Q0ZCdW5kbGVQYWNrYWdlVHlwZTwva2V5PgoJPHN0cmluZz5BUFBMPC9zdHJpbmc+Cgk8a2V5PkNGQnVuZGxlU2lnbmF0dXJlPC9rZXk+Cgk8c3RyaW5nPj8/Pz88L3N0cmluZz4KCTxrZXk+Tk9URTwva2V5PgoJPHN0cmluZz5QYXRjaGVkIGJ5IFZpY3RvciBIdWFuZyAmbHQ7aUBpbXZpY3Rvci50ZWNoJmd0OyBpbiBMWU9JPC9zdHJpbmc+Cgk8a2V5Pk5TUHJpbmNpcGFsQ2xhc3M8L2tleT4KCTxzdHJpbmc+TlNBcHBsaWNhdGlvbjwvc3RyaW5nPgo8L2RpY3Q+CjwvcGxpc3Q+Cg==" | base64 -d > lemon.app/Contents/Info.plist
mkdir /tmp/lemon_make/
cp -a lemon.app /tmp/lemon_make/
open /tmp/lemon_make/
open -a /Applications/Preview.app icon.png
echo "如果出现无图标，请拷贝此图像，然后在 lemon 上右键显示简介，将图像粘贴到左上角的图标上即可。"
read -sn 1
exit 0
