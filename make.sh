#!/bin/bash
echo "Qt 4 enviroment needed, press any key to start making..."
read -sn 1
cd "$(dirname "$0")"
cd project-lemon
command -v qmake >/dev/null 2>&1 || { (brew tap cartr/qt4 && brew tap-pin cartr/qt4 && brew install qt@4) 2>&1 || { echo >&2 "Requiring brew but it's not installed.  Aborting."; exit 1; } }
command -v rpl >/dev/null 2>&1 || { brew install rpl; }
rpl "Q_OS_LINUX" "Q_OS_MAC" ./*
rpl "memoryLimit *= 1024 * 1024;" "memoryLimit *= 1024;" ./watcher_unix.c # macOS memory limit fix
rpl "(usage.ru_maxrss) * 1024" "(usage.ru_maxrss)" ./watcher_unix.c # macOS memory usage fix
rpl "1024 * 1024" "1024" ./judgingthread.cpp # macOS memory limit fix
rm -f watcher_unix
gcc -o watcher_unix watcher_unix.c
echo >> lemon.pro
echo "ICON = lemon.icns" >> lemon.pro
mkdir tmp.iconset
sips -z 16 16     icon.png --out tmp.iconset/icon_16x16.png
sips -z 32 32     icon.png --out tmp.iconset/icon_16x16@2x.png
sips -z 32 32     icon.png --out tmp.iconset/icon_32x32.png
sips -z 64 64     icon.png --out tmp.iconset/icon_32x32@2x.png
sips -z 128 128   icon.png --out tmp.iconset/icon_128x128.png
sips -z 256 256   icon.png --out tmp.iconset/icon_128x128@2x.png
sips -z 256 256   icon.png --out tmp.iconset/icon_256x256.png
sips -z 512 512   icon.png --out tmp.iconset/icon_256x256@2x.png
sips -z 512 512   icon.png --out tmp.iconset/icon_512x512.png
sips -z 512 512   icon.png --out tmp.iconset/icon_512x512@2x.png
iconutil -c icns tmp.iconset -o lemon.icns
qmake
make
macdeployqt lemon.app
echo "PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPCFET0NUWVBFIHBsaXN0IFBVQkxJQyAiLS8vQXBwbGUvL0RURCBQTElTVCAxLjAvL0VOIiAiaHR0cDovL3d3dy5hcHBsZS5jb20vRFREcy9Qcm9wZXJ0eUxpc3QtMS4wLmR0ZCI+CjxwbGlzdCB2ZXJzaW9uPSIxLjAiPgo8ZGljdD4KCTxrZXk+Q0ZCdW5kbGVFeGVjdXRhYmxlPC9rZXk+Cgk8c3RyaW5nPmxlbW9uPC9zdHJpbmc+Cgk8a2V5PkNGQnVuZGxlR2V0SW5mb1N0cmluZzwva2V5PgoJPHN0cmluZz5MZW1vbiwg566A5piTT0nnq57otZvmtYvor5Xnjq/looM8L3N0cmluZz4KCTxrZXk+Q0ZCdW5kbGVJY29uRmlsZTwva2V5PgoJPHN0cmluZz5sZW1vbjwvc3RyaW5nPgoJPGtleT5DRkJ1bmRsZUlkZW50aWZpZXI8L2tleT4KCTxzdHJpbmc+b3JnLmx5b2kubGVtb248L3N0cmluZz4KCTxrZXk+Q0ZCdW5kbGVQYWNrYWdlVHlwZTwva2V5PgoJPHN0cmluZz5BUFBMPC9zdHJpbmc+Cgk8a2V5PkNGQnVuZGxlU2lnbmF0dXJlPC9rZXk+Cgk8c3RyaW5nPj8/Pz88L3N0cmluZz4KCTxrZXk+Tk9URTwva2V5PgoJPHN0cmluZz5QYXRjaGVkIGJ5IFZpY3RvciBIdWFuZyAmbHQ7aUBpbXZpY3Rvci50ZWNoJmd0OyBpbiBMWU9JPC9zdHJpbmc+Cgk8a2V5Pk5TUHJpbmNpcGFsQ2xhc3M8L2tleT4KCTxzdHJpbmc+TlNBcHBsaWNhdGlvbjwvc3RyaW5nPgo8L2RpY3Q+CjwvcGxpc3Q+Cg==" | base64 -d > lemon.app/Contents/Info.plist
mkdir /tmp/lemon_make/
cp -a lemon.app /tmp/lemon_make/
printf '\a\n'
echo "Done. Press any key to locate it."
read -sn 1
open /tmp/lemon_make/
exit 0
