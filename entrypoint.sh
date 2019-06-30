#!/usr/bin/env bash

readonly GITHUB_ACTOR
readonly GITHUB_TOKEN
readonly GITHUB_REPOSITORY

git clone https://${GITHUB_ACTOR}@${GITHUB_TOKEN}/${GITHUB_REPOSITORY}.git
cat gradle/wrapper/gradle-wrapper.properties

#curl -s -H "Authorization: Bearer $GITHUB_TOKEN" https://api.github.com/repos/gradle/gradle/releases/latest | jq
#curl -s "https://api.github.com/repos/$1/releases/latest" \
#            | jq -r ".tag_name" \
#            | python extractVersion.py