#/usr/bin/env bash

set -v

GRUBE_TMP=/tmp/grube
mkdir $GRUBE_TMP

if [[ -f "assets/prod-secrets.json" ]]; then
    mv assets/secrets.json $GRUBE_TMP/secrets.local.json
    mv assets/prod-secrets.json assets/secrets.json
fi

~/flutter/bin/flutter build appbundle

mv assets/secrets.json assets/prod-secrets.json
mv $GRUBE_TMP/secrets.local.json assets/secrets.json
