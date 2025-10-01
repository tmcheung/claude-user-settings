---
argument-hint: [jira-issue]
description: Solve jira issue
---

Read jira issue #$1 using MCP server and then solve it. If no jira issue is submitted, ask user for it. If jira issue is already completed then tell the user about it. If the description is unclear, ask clarifying questions.

Use the subagent planner to generate a high level plan and then create a file `plan.md` that includes the high level plan and a list of tasks that must be completed. Verify with user that the plan looks correct before proceeding with implementation using subagent implementer.