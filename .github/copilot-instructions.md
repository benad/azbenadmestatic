# Copilot Instructions

## Build Commands

```sh
npm ci                # install dependencies
npm run prebuild      # compile src/page.xsl → _generated/page.sef.json (required before first build or after XSL changes)
npm run build         # full build → _site/
npm run start         # build + local dev server with watch
npm run debug         # build with Eleventy debug output
```

`_generated/` and `_site/` are excluded from Git and must be generated locally.

## Architecture

This is an [Eleventy (11ty)](https://www.11ty.dev/) static site with **two content pipelines that apply anywhere under `content/`**:

### 1. Markdown or HTML + Nunjucks
- Source: any `.md` or `.html` file under `content/` (blog posts are in `content/blog/YYYY/`)
- Front matter: **TOML** (delimited with `---toml`, not YAML) for both `.md` and `.html` files
- `.html` source files contain raw HTML body content (no Markdown); used for older imported posts
- Template: `src/blogpost.njk` (uses `src/header.njk`, `src/sidebar.njk`, `src/footer.njk`)
- Collection name: `collections.post`
- Permalink pattern for blog posts: `blog/YYYY/MM/DD/<slugified-title>/` (auto-generated, or set explicitly via `permalink` in front matter)

### 2. XML + XSLT (Saxon-JS)
- Source: any `.xml` file under `content/` (e.g. `content/me.xml`, `content/articles.xml`, or an XML file inside `content/blog/`)
- Each XML file declares `<?xml-stylesheet type="text/xsl" href="page.xsl"?>` referencing an XSL file
- At build time, Eleventy's custom `xml` extension uses Saxon-JS to transform XML → HTML using the pre-compiled SEF file at `_generated/<name>.sef.json`
- Output: `<slug>.html` (except `index.xml` → `index.html` which is the RSS feed)
- Custom XML schema namespace: `http://benad.me/schema/page`
- `content/page_simple.xsl` is an alternate XSL stylesheet for simpler pages

### 11ty Configuration (`eleventy.config.js`)
- Input: `content/`, includes: `src/`, data: `_data/`, output: `_site/`
- Static assets from `src/public/` are copied to `_site/` root
- `src/twitter.zip` is extracted to `_site/twitter/` on first build
- Filters available in Nunjucks templates: `readableDate`, `htmlDateString`, `getYear`, `getMonth`, `getDay`, `parseDateString`, `getRssDate`

## Key Conventions

- **TOML front matter** for all blog posts — use `---toml` fences, not `---`
- **Timezone**: always use `"America/New_York"`, never `"America/Montreal"` (displays as GMT-5 otherwise)
- **XSL changes require `npm run prebuild`** to recompile the SEF JSON before the next build
- Blog posts are organized into per-year subdirectories: `content/blog/YYYY/`
- Deployed to **Azure Static Web Apps** via GitHub Actions (`.github/workflows/`); pushes to `main` deploy to production, pushes to `dev` create preview environments
- Node version is managed with `fnm`; run `fnm install && fnm use` if version doesn't match `.node-version`
