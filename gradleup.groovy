import groovy.json.*

def api = new JsonSlurper().parse(System.in)
def wrapperConfig = new File("gradle/wrapper/gradle-wrapper.properties")

def version = api.name
def lines = wrapperConfig.readLines()
def distributionType = "bin"

for (int i = 0; i < lines.size(); i++) {
    if (lines[i].startsWith('distributionUrl')) {
        if (lines[i].contains("-all")) {
            distributionType = "all"
        }
        lines[i] = "distributionUrl=https\\://services.gradle.org/distributions/gradle-${version}-${distributionType}.zip".toString()
    }
}

wrapperConfig.text = lines.join('\n') + '\n'

new File('/tmp/commit.txt').text =
        "Update gradle wrapper to ${version}\n\n${api.body}"

new File('/tmp/request.json').text =
        new JsonBuilder([
                title: "Gradle wrapper updated to ${version}",
                body : api.body,
                base : 'master',
                head : "${System.getenv("GITHUB_ACTOR")}:${System.getenv("BRANCH_NAME")}"
        ]).toPrettyString()
