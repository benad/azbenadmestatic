---
name: Git Commit Attribution
description: How to attribute commits made by Antigravity CLI.
---

# Git Commit Attribution

Use this skill only when a commit is being made by the Antigravity CLI client. Do not apply this attribution rule to GitHub Copilot CLI or other clients.

## Workflow

1. When committing as the Antigravity CLI client, prepare the changes and write the commit message.
2. At the end of the commit message, add the `Co-authored-by` trailer for Antigravity CLI.
3. The format of the trailer must be exactly:
   ```
   Co-authored-by: Antigravity CLI <antigravity-support@google.com>
   ```
