#!/usr/bin/env bash

MACOSX_DEPLOYMENT_TARGET=${MACOSX_DEPLOYMENT_TARGET:-10.9}

echo "Downloading ${MACOSX_DEPLOYMENT_TARGET} sdk"

curl -L -O https://github.com/phracker/MacOSX-SDKs/releases/download/10.13/MacOSX${MACOSX_DEPLOYMENT_TARGET}.sdk.tar.xz

tar -xf MacOSX${MACOSX_DEPLOYMENT_TARGET}.sdk.tar.xz -C "$(xcode-select -p)/Platforms/MacOSX.platform/Developer/SDKs"

