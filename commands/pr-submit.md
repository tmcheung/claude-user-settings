Use the subagent pr-composer to create a pull request with the committed changes, if currently on the `main` or `master` branch then prompt user about it to understand which action should be done:
1. To create a new branch with a fitting name using jira issue, description of changes, etc. as context. Suggest a branch new.
2. Abort the pull request creation

If there are any uncommitted changes then prompt user about it to understand which action should be done:
1. To commit with suggested commit message. Generate message based on changes
2. Abort the pull request creation