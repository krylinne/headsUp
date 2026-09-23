#!/bin/bash
set -e

swift build -c release

rm -rf headsUp.app
mkdir -p headsUp.app/Contents/MacOS
cp .build/release/headsUp headsUp.app/Contents/MacOS/headsUp
cp Info.plist headsUp.app/Contents/Info.plist

codesign --force --deep --sign - headsUp.app

echo "Built headsUp.app"