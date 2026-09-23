#!/bin/bash
set -e

APP_NAME="headsUp"
BUNDLE_ID="com.krylinne.headsup"
SIGNING_IDENTITY="krylinne"

swift build -c release

rm -rf "${APP_NAME}.app"
mkdir -p "${APP_NAME}.app/Contents/MacOS"
cp .build/release/${APP_NAME} "${APP_NAME}.app/Contents/MacOS/${APP_NAME}"
cp Info.plist "${APP_NAME}.app/Contents/Info.plist"

codesign --force --deep --sign "${SIGNING_IDENTITY}" \
  -r="designated => identifier \"${BUNDLE_ID}\"" \
  "${APP_NAME}.app"

echo "Built and signed ${APP_NAME}.app"