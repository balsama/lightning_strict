#!/usr/bin/env sh
mkdir -p tmp

if [ ! -d "tmp/lightning" ]; then
  git clone --branch 8.x-3.x https://github.com/acquia/lightning.git tmp/lightning
fi

if [ ! -d "tmp/metapackage" ]; then
  git clone --branch master git@github.com:balsama/lightning_strict.git tmp/metapackage
fi
