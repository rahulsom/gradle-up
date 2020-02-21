#!/usr/bin/env bash

set -exvu

readonly GITHUB_ACTOR
readonly GITHUB_TOKEN
readonly GITHUB_REPOSITORY

readonly LATEST_GRADLE_API=https://api.github.com/repos/gradle/gradle/releases/latest
readonly AUTH_HEADER="Authorization: Token $GITHUB_TOKEN"

export BRANCH_NAME=gradle-up

cd /tmp
git clone https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git work
cd work/

git fetch --all

if [[ $(git ls-remote --heads origin | grep -c "refs/heads/$BRANCH_NAME") = 1 ]]; then
    git checkout $BRANCH_NAME
else
    git checkout -b $BRANCH_NAME
fi

curl -s -H "${AUTH_HEADER}" ${LATEST_GRADLE_API} | groovy /gradleup.groovy

if [[ $(git diff | wc -l) != 0 ]]; then
    git diff
    git add ./gradle/wrapper/gradle-wrapper.properties

    git config user.email "${GITHUB_ACTOR}@githubactions.com"
    git config user.name "${GITHUB_ACTOR} GradleUp Action"

    if [[ $(git ls-remote --heads origin | grep -c "refs/heads/$BRANCH_NAME") = 1 ]]; then
        git commit --amend -F /tmp/commit.txt
        git push -u origin $BRANCH_NAME --force
    else
        git commit -F /tmp/commit.txt
        git push -u origin $BRANCH_NAME

        cat /tmp/request.json
        curl -H "${AUTH_HEADER}" -d @/tmp/request.json https://api.github.com/repos/${GITHUB_REPOSITORY}/pulls
    fi
fi
