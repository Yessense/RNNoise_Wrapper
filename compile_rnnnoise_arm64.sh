#!/bin/bash

ZIP_RNNOISE_SOURCE="rnnoise_master_20.11.2020.zip"

if [ ! -f "$ZIP_RNNOISE_SOURCE" ]; then
    echo -e "\n[E] Archive ${ZIP_RNNOISE_SOURCE} not found\n"
    exit 1
fi

if ! command -v autoconf &> /dev/null || ! command -v automake &> /dev/null || ! command -v libtool &> /dev/null; then
    echo "Installing build dependencies (autoconf, automake, libtool)..."
    brew install autoconf automake libtool
fi

unzip "$ZIP_RNNOISE_SOURCE"
cd rnnoise-master

./autogen.sh

export CFLAGS="-arch arm64"
export LDFLAGS="-arch arm64"
./configure --enable-shared

make

cd -

mkdir -p rnnoise_wrapper/libs
mv rnnoise-master/.libs/librnnoise.0.dylib rnnoise_wrapper/libs/librnnoise_default.0.4.1.dylib

rm -rf rnnoise-master

echo -e "\n'librnnoise_default.0.4.1.dylib' has been successfully moved to 'rnnoise_wrapper/libs/'"
