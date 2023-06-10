const pluginRss = require("@11ty/eleventy-plugin-rss");
const { DateTime } = require("luxon");
const SaxonJS = require("saxon-js");
const toml = require("@iarna/toml");
const extract = require('extract-zip')
const fs = require('node:fs');

const xslDir = 'generated';
const twitterZip = 'src/twitter.zip'

var parseDate = function (dateObj, zone) {
	return DateTime.fromJSDate(dateObj, { zone: zone || "America/New_York" });
};

/** @param {import("@11ty/eleventy").UserConfig} eleventyConfig */
module.exports = function (eleventyConfig) {
	eleventyConfig.addPlugin(pluginRss);
	
	// Copy the contents of the `public` folder to the output folder
	// For example, `./public/css/` ends up in `_site/css/`
	eleventyConfig.addPassthroughCopy({
		"./public/": "/"
	});

	// Watch content images for the image pipeline.
	eleventyConfig.addWatchTarget("content/**/*.{svg,webp,png,jpeg}");

	// Filters
	eleventyConfig.addFilter("readableDate", (dateObj, format, zone) => {
		// Formatting tokens for Luxon: https://moment.github.io/luxon/#/formatting?id=table-of-tokens
		return parseDate(dateObj, zone).toFormat(format || "LLLL d, yyyy");
	});

	eleventyConfig.addFilter('htmlDateString', (dateObj) => {
		// dateObj input: https://html.spec.whatwg.org/multipage/common-microsyntaxes.html#valid-date-string
		return DateTime.fromJSDate(dateObj, { zone: 'utc' }).toFormat('yyyy-LL-dd');
	});

	eleventyConfig.addFilter('getYear', (dateObj, zone) => {
		return parseDate(dateObj, zone).toFormat('y');
	});

	eleventyConfig.addFilter('getMonth', (dateObj, zone) => {
		return parseDate(dateObj, zone).toFormat('LL');
	});

	eleventyConfig.addFilter('getDay', (dateObj, zone) => {
		return parseDate(dateObj, zone).toFormat('dd');
	});

	eleventyConfig.addFilter('parseDateString', (dateStr) => {
		return new Date(dateStr);
	});

	eleventyConfig.addFilter('getRssDate', (dateObj, zone) => {
		return parseDate(dateObj, zone).toRFC2822();
	});

	eleventyConfig.setFrontMatterParsingOptions({
		engines: {
			toml: toml.parse.bind(toml)
		}
	});

	eleventyConfig.addTemplateFormats("xml");

	eleventyConfig.addExtension("xml", {
		compile: async function (inputContent) {
			var xslpath = xslDir + "/" + inputContent.match(/<\?xml-stylesheet .*href="([^"]+)" *\?>/)[1];
			xslpath = xslpath.replace(".xsl", ".sef.json");
			let xmlout = SaxonJS.transform({
				stylesheetFileName: xslpath,
				sourceText: inputContent,
				destination: "serialized"
			}, "sync");
			return (data) => {
				return xmlout.principalResult;
			};
		},
		compileOptions: {
			permalink: function (contents, inputPath) {
				return (data) => {
					if (data.page.filePathStem == '/index')
						return 'index.html';
					return data.page.fileSlug + '.html';
				}
			},
		}
	});

	eleventyConfig.on('eleventy.after', async ({ dir, results, runMode, outputMode }) => {
		if (outputMode == 'fs') {
			const dest = process.cwd() + '/' + dir.output;
			if (!fs.existsSync(dest + '/twitter')) {
				console.log('Unzipping %s to %s', twitterZip, dest);
				return extract(twitterZip, { dir: dest });
			}
		}
	});

	return {
		// These are all optional:
		dir: {
			input: "content",          // default: "."
			includes: "../_includes",  // default: "_includes"
			data: "../_data",          // default: "_data"
			output: "_site"
		},
		passthroughFileCopy: true,
		pathPrefix: "/",
	};
};