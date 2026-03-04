---
name: update-pr-description
description: Update the description of the current branch's open pull request based on the latest changes compared to the target branch.
argument-hint: []
disable-model-invocation: false
---

1. Resolve the current PR and its target branch by running `gh pr view --json baseRefName,number,url`. If no open PR exists for the current branch, inform the user and stop.
2. Delegate to the pr-composer subagent to *update* the existing PR. Pass the PR number and the target branch so it can analyze the diff against the target branch, generate the description, and apply it with `gh pr edit`.
