import groovy.json.*
def api = new JsonSlurper().parse(System.in)

def version = api.tag_name.substring(1)
def lines = new File("gradle/wrapper/gradle-wrapper.properties").readLines()
for (int i = 0; i < lines.size(); i ++) {
    if (lines[i].startsWith('distributionUrl')) {
        lines[i] = "distributionUrl=https\\://services.gradle.org/distributions/gradle-${version}-all.zip".toString()
    }
}
new File("gradle/wrapper/gradle-wrapper.properties").text = lines.join('\n') + '\n'
new File('/tmp/commit.txt').text = "Update gradle wrapper to ${version}\n\n${api.body}"
new File('/tmp/request.json').text = new JsonBuilder([
        title: "Update gradle wrapper to ${version}",
        body: api.body,
        base: 'master',
        head: "${System.getenv("GITHUB_ACTOR")}:${System.getenv("BRANCH_NAME")}"
]).toPrettyString()