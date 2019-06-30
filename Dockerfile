FROM groovy:2.5-jdk8

LABEL "com.github.actions.name"="Update Gradle Wrapper"
LABEL "com.github.actions.description"="Updates gradle wrapper for repo"
LABEL "com.github.actions.icon"="arrow-up-circle"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="http://github.com/rahulsom/gradle-up"
LABEL "homepage"="http://github.com/rahulsom/gradle-up"
LABEL "maintainer"="Rahul Somasunderam <rahul.som@gmail.com>"

USER root

RUN apt-get update \
    && apt-get install --yes \
        git \
    && rm --recursive --force /var/lib/apt/lists/*

USER groovy

ADD entrypoint.sh /entrypoint.sh
ADD gradleup.groovy /gradleup.groovy

ENTRYPOINT ["/entrypoint.sh"]