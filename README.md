## Dependencies
Some dependencies should be setup for optimal usage. Note that MCP servers are avoided to reduce using up context and to avoid short lived auth tokens.

### Notifications when agent and subagents are waiting for input or done processing

`terminal-notifier` for notifications when agent needs your input or task is complete:
```brew install terminal-notifier```

### Jira interactions
Atlassian CLI, `acli` is preferred over the MCP server. See setup guide: https://developer.atlassian.com/cloud/acli/guides/how-to-get-started/

### Github interactions
Github CLI, `gh` is preferred over the mCP server. See setup guide: https://github.com/cli/cli#installation


