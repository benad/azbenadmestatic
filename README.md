# benad.me Sources

[![CC BY-SA 4.0][cc-by-sa-shield]][cc-by-sa]

Source files for [benad.me](https://benad.me/).

This work is licensed under a
[Creative Commons Attribution-ShareAlike 4.0 International License][cc-by-sa].

Author: Benoit Nadeau

## HOWTO

Requires NodeJS 18+

```sh
npm install
npm run build
```

The site will be under `_site`.

For the files `*.html` at the first level, it is expected for `X.xml` to redirect
to `X.html`, excepted for `index.xml` (which is the RSS of the site).
See `staticwebapp.config.json`.

## Structure

* `eleventy.config.js`: 11ty config.
* `content`: Input page content files for 11ty.
* `src`: 11ty templates and input files.
* `src/public`: Additional static files to add to the files generated by 11ty.
* `src/scripts`: Scripts used to generate or tweak the content files.
* `_generated`*: Additional generated files needed as input for 11ty.
* `_site`*: Web site, once generated by 11ty.

\*: Files excluded from Git.

## References

* https://github.com/11ty/eleventy-base-blog
* https://moment.github.io/luxon/
* https://mozilla.github.io/nunjucks/
* https://www.saxonica.com/saxon-js/documentation2/index.html#!api/transform
* https://github.com/santisoler/cc-licenses#cc-attribution-sharealike-40-international

## Notes

Don't use "America/Montreal", otherwise it will show up only as "GMT-5". Use
"America/New_York".

The file `generated/page.sef.json` must be generated or updated from
`src/page.xsl` using `npm run prebuild`.

Right now, `xml` assumes the header `<?xml-stylesheet type="text/xsl"...` has an
href that points to the `xsl` file that should have its `generated/*.sef.json`.

Moving to per-year `content` folders:

```ps1
$YEAR=2022
mkdir .\content\blog_${YEAR}
Copy-Item .\content\blog_2023\blog_2023.11tydata.js .\content\blog_${YEAR}\blog_${YEAR}.11tydata.js
rg -l "date = .$YEAR-" .\content | foreach { Move-Item -Destination .\content\blog_${YEAR} $_ }
```

[cc-by-sa]: https://creativecommons.org/licenses/by-sa/4.0/
[cc-by-sa-image]: https://licensebuttons.net/l/by-sa/4.0/88x31.png
[cc-by-sa-shield]: https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg