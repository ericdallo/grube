#/usr/bin/env bash

mv assets/secrets.json assets/secrets.local.json
mv assets/prod-secrets.json assets/secrets.json

~/flutter/bin/flutter build appbundle

mv assets/secrets.json assets/prod-secrets.json
mv assets/secrets.local.json assets/secrets.json
