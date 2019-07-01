# gradle-up

Supports updating the gradle wrapper through a pull request.

You can do something like this to use this action

```
workflow "Daily" {
  on = "schedule(0 0 * * *)"
  resolves = ["Update Gradle Wrapper"]
}

action "Update Gradle Wrapper" {
  uses = "rahulsom/gradle-up@master"
  secrets = ["GITHUB_TOKEN"]
}
```
