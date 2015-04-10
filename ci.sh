#!/bin/bash
set -e

cd tests

rm -rf Export

haxelib run duell update -verbose -yestoall

haxelib run duell build android -emulator -test -verbose -D jenkins -yestoall

haxelib run duell build html5 -test -verbose -D jenkins -yestoall

haxelib run duell build flash -test -verbose -D jenkins -yestoall

haxelib run duell build ios -test -verbose -D jenkins -yestoall
