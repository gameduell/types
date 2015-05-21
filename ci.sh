#!/bin/bash
set -e

cd tests

rm -rf Export

haxelib run duell_duell update -verbose -yestoall

haxelib run duell_duell build android -emulator -test -verbose -D jenkins -yestoall -x86

haxelib run duell_duell build html5 -test -verbose -D jenkins -yestoall

haxelib run duell_duell build flash -test -verbose -D jenkins -yestoall

haxelib run duell_duell build ios -test -verbose -D jenkins -yestoall
