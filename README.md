# github-release-action
Github action to auto release tag
Example:
```
name: Publish Github Release

on:
  push:
    branches:
      - 'main'

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: Create a Release
      uses: sugerio/github-release-action@main
      env:
        GITHUB_TOKEN: ${{ secrets.RELEASE_TOKEN }}
      with:
        commit_message: "sample-commit-message"
```