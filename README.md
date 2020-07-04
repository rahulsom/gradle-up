# gradle-up

Supports updating the gradle wrapper through a pull request.

You can do something like this to use this action

```yaml
name: Update Gradle Wrapper

on:
  schedule:
  - cron: '0 0 * * *'

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: rahulsom/gradle-up@v0.2.0
      env:
        GITHUB_TOKEN: ${{secrets.GITHUB_TOKEN}}
```
