const { default: pluginRss } = require("@11ty/eleventy-plugin-rss");
const { DateTime } = require("luxon");
const { XSLTProcessor } = require("@tradik/xslt-processor");
const { JSDOM } = require("jsdom");
const toml = require("@iarna/toml");
const AdmZip = require('adm-zip');
const fs = require('node:fs');
const path = require('node:path');
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
		"./src/public/": "/"
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
			const xslFilename = inputContent.match(/<\?xml-stylesheet .*href="([^"]+)" *\?>/)[1];
			let xslpath = path.join(process.cwd(), "src", xslFilename);
			if (!fs.existsSync(xslpath)) {
				xslpath = path.join(process.cwd(), "content", xslFilename);
			}

			const xslText = fs.readFileSync(xslpath, "utf-8");
			
			const dom = new JSDOM("<!DOCTYPE html><html><body></body></html>", { contentType: "text/html" });
			
			// Expose DOM globals for xslt-processor
			const originalDocument = global.document;
			const originalDOMParser = global.DOMParser;
			const originalXMLSerializer = global.XMLSerializer;
			
			global.document = dom.window.document;
			global.DOMParser = dom.window.DOMParser;
			global.XMLSerializer = dom.window.XMLSerializer;

			let html;
			try {
				const parser = new dom.window.DOMParser();
				const xslDoc = parser.parseFromString(xslText, "application/xml");
				const xmlDoc = parser.parseFromString(inputContent, "application/xml");

				const processor = new XSLTProcessor();
				processor.importStylesheet(xslDoc);

				const fragment = processor.transformToFragment(xmlDoc, dom.window.document);
				const tempDiv = dom.window.document.createElement("div");
				tempDiv.appendChild(fragment);
				
				html = tempDiv.innerHTML;
				
				if (!html.startsWith("<!DOCTYPE")) {
					html = "<!DOCTYPE html>\n" + html;
				}
			} finally {
				global.document = originalDocument;
				global.DOMParser = originalDOMParser;
				global.XMLSerializer = originalXMLSerializer;
			}

			return (data) => {
				return html;
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
				new AdmZip(twitterZip).extractAllTo(dest, true);
			}
		}
	});

	return {
		// These are all optional:
		dir: {
			input: "content",          // default: "."
			includes: "../src",  // default: "_includes"
			data: "../_data",          // default: "_data"
			output: "_site"
		},
		passthroughFileCopy: true,
		pathPrefix: "/",
	};
};