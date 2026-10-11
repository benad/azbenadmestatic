---
name: Security Update
description: Apply npm-first dependency security updates, synchronize Deno's lockfile, and verify generated site output.
---

# Security Update

Use this skill to remediate dependency vulnerabilities while verifying that the generated site remains unchanged.

## Workflow

1. Review the working tree and preserve any existing user changes.
2. Install the current npm lockfile and build a baseline:
   * `npm ci`
   * `npm run build`
3. Copy `_site/` to a snapshot outside the repository. Also preserve byte-for-byte copies of `package.json` and `package-lock.json` before attempting dependency updates, so pre-existing worktree changes are preserved and can be detected. Keep the snapshot and generated `_site/` out of Git.
4. Review the audit findings with `npm audit`, then apply npm-first updates as documented in `README.md`:
   * Run `npm audit fix` for vulnerabilities.
   * Use `npm install <package>` when a specific package needs to be added or updated.
   * Do not use `npm audit fix --force` or make major-version updates without approval. If a fix cannot be applied safely, report the unresolved findings instead of hiding them.
5. Compare `package.json` and `package-lock.json` with copies captured before attempting updates. If both files are unchanged, no npm dependency update occurred: run `npm audit` once more and record the remaining findings, then delete the external baseline snapshot. Skip Deno lockfile regeneration, the follow-up `npm ci`, the second build, and generated-output comparison; there is no updated dependency state to validate. Do not claim the output was compared or verified unchanged. If either file changed, continue with the remaining steps.
6. Regenerate Deno's lockfile from the updated npm manifests, following `README.md`:
   * `rm deno.lock`
   * `deno install`
   If Deno is unavailable, follow the README's setup instructions or report that lockfile synchronization could not be completed.
7. Run `npm audit` again and record any remaining findings. Then run `npm ci` to verify the updated npm lockfile can be installed cleanly.
8. Run `npm run build` and compare the resulting `_site/` with the baseline snapshot.
9. Treat only the RSS `<lastBuildDate>` change in `content/blogrss.njk` as expected timestamp noise. Investigate any other generated-file difference; do not report the output as unchanged unless all other files are byte-identical.

## Rules

- Drive dependency changes through npm first, then synchronize `deno.lock`, as required by `README.md`.
- Do not discard lockfile or package changes made by the user.
- If audit findings remain or the output differs beyond the RSS timestamp, report the details and do not claim the update is fully verified.
- Do not commit `_site/` or the external baseline snapshot.
