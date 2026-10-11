---
name: Security Update PR
description: Turn fixable npm audit findings into a verified security-update branch and pull request.
---

# Security Update PR

Use this skill to prepare a verified security-update pull request.

## Workflow

0. Run `npm audit` before creating a branch.
   * If it completes successfully and reports zero vulnerabilities, stop; do not create a branch, commit, push, or PR.
   * If it fails for an operational reason (for example, registry access or an invalid lockfile), stop and report the error. Do not treat an audit failure as a clean audit.
1. Check `git status --short`. If the worktree is not clean, stop and report the existing changes; do not stash, discard, or include unrelated work.
2. Fetch and fast-forward `main` before branching:
   * `git fetch origin main`
   * `git switch main`
   * `git merge --ff-only origin/main`
   If `main` cannot be updated safely, stop and report the issue.
3. Choose a unique branch name for the current month:
   * Set `YYYYMM` from the current date (`date +%Y%m`).
   * Inspect merge commits in `git log main --merges --format=%B` for source branch names matching `security-YYYYMM` or `security-YYYYMM-N`. Count only branch names in merge references, not advisory IDs or unrelated commit text.
   * If there is no matching branch in `main`'s history, use `security-YYYYMM`. Otherwise treat the unsuffixed name as number 1, find the largest existing suffix, and use the next number (starting with `-2`).
   * Check local and remote refs too. If the proposed name already exists, do not reuse or overwrite it; choose the next unused suffix.
   * Create the branch from the updated `main` with `git switch -c <branch-name>`.
4. Follow `.agents/skills/security-update/SKILL.md` on the new branch. Record the dependency-manifest and lockfile state immediately before `npm audit fix`, then check whether it changed those files immediately afterward.
   * If `npm audit fix` makes no dependency-manifest or lockfile changes, stop the workflow: switch back to `main`, delete the branch created in step 3 with `git branch -d <branch-name>`, and report that no update was made. Do not continue with manual package updates, push, or create a PR.
   * Delete only the branch created by this run. If returning to `main` or safely deleting that branch is blocked, stop and report the blocker without discarding other changes.
5. Before committing, confirm the update is complete:
   * `npm audit` reports zero remaining vulnerabilities.
   * The updated npm and Deno lockfiles are synchronized as documented in `README.md`.
   * The build succeeds, and generated `_site/` files match the baseline byte-for-byte except for the expected RSS `<lastBuildDate>` timestamp in `blog/index.xml`.
   * If audit findings remain, the build fails, lockfile synchronization fails, or any other generated output differs, stop before commit/push/PR and report the blocker.
6. Review the diff. Commit only the security-update changes. Use a commit subject that mentions the package or security fix, and include the relevant advisory IDs or links in the commit message body. Include this required trailer:
   * `Co-authored-by: Antigravity CLI <antigravity-support@google.com>`
7. Push the branch without force:
   * `git push --set-upstream origin <branch-name>`
8. Create a PR against `main` with `gh pr create`. Use the commit subject as a suitable title. In the description:
   * Summarize the packages and versions changed.
   * Link each fixed security advisory using the authoritative URL shown by `npm audit` or its advisory source; do not invent links.
   * Mention Deno lockfile synchronization and include the verification results from step 5.
   * Use [PR #60](https://github.com/benad/azbenadmestatic/pull/60) as the description example.

## Rules

- Do not make dependency changes on `main`.
- Do not use `npm audit fix --force` or overwrite existing branches.
- If `npm audit fix` makes no dependency-manifest or lockfile change, remove this run's new branch and stop without pushing or opening a PR.
- Do not commit, push, or create a PR for an update that has unresolved audit findings or failed verification.
- Do not claim verification checks passed unless they were actually run.
