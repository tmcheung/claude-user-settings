---
name: pr-submit
description: Create a pull request with committed changes. Use when the user wants to submit a PR.
argument-hint: []
disable-model-invocation: false
---

Use the subagent pr-composer to create a pull request with the committed changes, if currently on the `main` or `master` branch then prompt user about it to understand which action should be done:
1. To create a new branch with a fitting name using jira issue, description of changes, etc. as context. Suggest a branch new.
2. Abort the pull request creation

If there are any uncommitted changes then prompt user about it to understand which action should be done:
1. To commit with suggested commit message (Generate message based on changes first and present the suggestion). 
2. Abort the pull request creation
