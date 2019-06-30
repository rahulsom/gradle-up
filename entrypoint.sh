#!/usr/bin/env bash

set -exvu

readonly GITHUB_ACTOR
readonly GITHUB_TOKEN
readonly GITHUB_REPOSITORY

readonly LATEST_GRADLE_API=https://api.github.com/repos/gradle/gradle/releases/latest
readonly AUTH_HEADER="Authorization: Token $GITHUB_TOKEN"

export BRANCH_NAME=gradle-up

git clone https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git work
cd work/

git fetch --all

if [[ $(git ls-remote --heads origin | grep -c "refs/heads/$BRANCH_NAME") = 1 ]]; then
    git push origin :$BRANCH_NAME
fi

git checkout -b $BRANCH_NAME
curl -s -H "${AUTH_HEADER}" ${LATEST_GRADLE_API} | groovy /gradleup.groovy

git diff

git add .

git config --global user.email "${GITHUB_ACTOR}@githubactions.com"
git config --global user.name "${GITHUB_ACTOR} GradleUp Action"

git commit -F /tmp/commit.txt
git push -u origin $BRANCH_NAME

cat /tmp/request.json
curl -H "${AUTH_HEADER}" -d @/tmp/request.json https://api.github.com/repos/${GITHUB_REPOSITORY}/pulls

#curl -s "https://api.github.com/repos/$1/releases/latest" \
#            | jq -r ".tag_name" \
#            | python extractVersion.py