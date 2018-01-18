#!/bin/bash
set -e

cd tmp/metapackage

# Clean up after build script and checkout the branch currently being built
# which should have the encrypted private key.
git reset --hard
git clean -f -d
git checkout ${TRAVIS_BRANCH}

# Decrypt and add private key. We need it so we can push the generated tags and
# branched to the repo from the CI server.
ENCRYPTED_KEY_VAR="encrypted_${ENCRYPTION_LABEL}_key"
ENCRYPTED_IV_VAR="encrypted_${ENCRYPTION_LABEL}_iv"
ENCRYPTED_KEY=${!ENCRYPTED_KEY_VAR}
ENCRYPTED_IV=${!ENCRYPTED_IV_VAR}
openssl aes-256-cbc -K $ENCRYPTED_KEY -iv $ENCRYPTED_IV -in travis-lightning_strict.enc -out travis-lightning_strict -d
chmod 600 travis-lightning_strict
eval `ssh-agent -s`
ssh-add travis-lightning_strict

git push --all origin
git push --tags origin
