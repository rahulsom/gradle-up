FROM groovy:2.5-jdk8

LABEL "com.github.actions.name"="Update Gradle Wrapper"
LABEL "com.github.actions.description"="Updates gradle wrapper for repo"
LABEL "com.github.actions.icon"="arrow-up-circle"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="http://github.com/rahulsom/gradle-up"
LABEL "homepage"="http://github.com/rahulsom/gradle-up"
LABEL "maintainer"="Rahul Somasunderam <rahul.som@gmail.com>"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]