# benad.me 11ty Test

[![CC BY-SA 4.0][cc-by-sa-shield]][cc-by-sa]

This work is licensed under a
[Creative Commons Attribution-ShareAlike 4.0 International License][cc-by-sa].

## Links

* https://github.com/11ty/eleventy-base-blog
* https://moment.github.io/luxon/
* https://mozilla.github.io/nunjucks/
* https://www.saxonica.com/saxon-js/documentation2/index.html#!api/transform
* https://github.com/santisoler/cc-licenses#cc-attribution-sharealike-40-international

## Notes

Don't use "America/Montreal", otherwise it will show up only as "GMT-5". Use
"America/New_York".

`single.njk` has an example of how to "group" items in a page. This simulates
Hugo's Paginator.PageGroups fonctionality.

The file `src/page.sef.json` must be generated or updated from `src/page.xsl`
using `npm run xslt-compile`. In the future this could be done automatically by
the `xml` extension in `eleventy.config.js`.

Right now, `xml` assumes the header `<?xml-stylesheet type="text/xsl"...` has an
href that points to the `xsl` file that should have its `src/*.sef.json`.

### Converting Blog Posts

Change `+++\n(?<front>.*\n)+++\n` to `---toml\n$<front>---\n`

Syntax: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/replace .

In that `$<front>`:
* Remove `type = "post"`
* Change `url = "(?<urlval>.*)"` with `permalink = "$<urlval>/"` (notice the trailing `/`)

[cc-by-sa]: https://creativecommons.org/licenses/by-sa/4.0/
[cc-by-sa-image]: https://licensebuttons.net/l/by-sa/4.0/88x31.png
[cc-by-sa-shield]: https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg