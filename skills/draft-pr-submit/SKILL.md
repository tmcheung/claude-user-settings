---
name: draft-pr-submit
description: Create a draft pull request. Optionally accepts a task description to implement before submitting. Use when the user wants to submit a draft PR, with or without a preceding task.
argument-hint: [task-to-solve-before-submitting]
disable-model-invocation: false
---

If an argument is provided, treat it as a task to complete first:
1. Implement the task described in the argument (e.g. "reduce log level of ...", "fix typo in ...", "add validation for ...").
2. Commit the changes with an appropriate commit message.

Then, regardless of whether an argument was provided:
1. If currently on the `main` or `master` branch, create a new branch with a fitting name using jira issue, description of changes, etc. as context.
2. Use the subagent pr-composer to create a draft pull request with the committed changes.
