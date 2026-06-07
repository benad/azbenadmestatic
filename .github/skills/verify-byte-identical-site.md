---
name: Verify Generated Site Is Byte-Identical
description: Build a baseline, rebuild after a change, and diff _site/ to prove the generated site did not change.
---

# Verify Generated Site Is Byte-Identical

Use this skill when you need to prove a site change preserved the generated output.

## Workflow

1. Run `npm ci` and `npm run build`.
2. Copy `_site/` to a snapshot outside the repo.
3. Make the change.
4. Re-run `npm run build` after the change.
5. Diff the new `_site/` against the snapshot.
6. Treat the RSS `<lastBuildDate>` change in `content/blogrss.njk` as expected build noise.

## Rules

- Use `npm run build`.
- Keep `_generated/` and `_site/` out of git.
- If the diff is not just expected timestamp noise, investigate the rendering change before shipping.

## Useful when

- Verifying Eleventy upgrades.
- Checking template edits for accidental output changes.
- Proving a refactor is behavior-preserving.
