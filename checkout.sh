#!/bin/bash
set -e

# Decrypt and add private key. We need it here to checkout the metapackage and
# later push to it with an SSH key.
ENCRYPTED_KEY_VAR="encrypted_${ENCRYPTION_LABEL}_key"
ENCRYPTED_IV_VAR="encrypted_${ENCRYPTION_LABEL}_iv"
ENCRYPTED_KEY=${!ENCRYPTED_KEY_VAR}
ENCRYPTED_IV=${!ENCRYPTED_IV_VAR}
openssl aes-256-cbc -K $ENCRYPTED_KEY -iv $ENCRYPTED_IV -in travis-lightning_strict.enc -out travis-lightning_strict -d
chmod 600 travis-lightning_strict
eval `ssh-agent -s`
ssh-add travis-lightning_strict

# Checkout the source (Lightning) and metapackage (this repo)
mkdir -p tmp

if [ ! -d "tmp/lightning" ]; then
  git clone --branch 8.x-3.x https://github.com/acquia/lightning.git tmp/lightning
fi

if [ ! -d "tmp/metapackage" ]; then
  git clone --branch ${TRAVIS_BRANCH} git@github.com:balsama/lightning_strict.git tmp/metapackage
fi
