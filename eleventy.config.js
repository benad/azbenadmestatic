const { default: pluginRss } = require("@11ty/eleventy-plugin-rss");
const { DateTime } = require("luxon");
const { XSLTProcessor } = require("@tradik/xslt-processor");
const { DOMImplementation, DOMParser } = require("@xmldom/xmldom");
const toml = require("@iarna/toml");
const AdmZip = require('adm-zip');
const fs = require('node:fs');
const path = require('node:path');
const twitterZip = 'src/twitter.zip'

var parseDate = function (dateObj, zone) {
	return DateTime.fromJSDate(dateObj, { zone: zone || "America/New_York" });
};

// Custom HTML Serializer to serialize W3C XML DOM into browser-compatible HTML
function serializeToHTML(node, isRoot = false) {
	if (!node) return "";

	switch (node.nodeType) {
		case 1: { // Element
			const tagName = node.tagName.toLowerCase();
			let attrs = "";
			if (node.attributes) {
				for (let i = 0; i < node.attributes.length; i++) {
					const attr = node.attributes[i];
					attrs += ` ${attr.name}="${escapeAttr(attr.value)}"`;
				}
			}

			const voidElements = new Set([
				"area", "base", "br", "col", "embed", "hr", "img", "input",
				"link", "meta", "param", "source", "track", "wbr"
			]);

			if (voidElements.has(tagName)) {
				return `<${tagName}${attrs}>`;
			}

			let children = "";
			if (node.childNodes) {
				for (let i = 0; i < node.childNodes.length; i++) {
					children += serializeToHTML(node.childNodes[i], false);
				}
			}

			return `<${tagName}${attrs}>${children}</${tagName}>`;
		}

		case 3: // Text
			if (isRoot && /^\s*$/.test(node.nodeValue)) {
				return "";
			}
			return escapeText(node.nodeValue);

		case 8: // Comment
			return `<!--${node.nodeValue}-->`;

		case 9: // Document
		case 11: { // DocumentFragment
			let children = "";
			if (node.childNodes) {
				for (let i = 0; i < node.childNodes.length; i++) {
					children += serializeToHTML(node.childNodes[i], true);
				}
			}
			return children;
		}

		default:
			return "";
	}
}

function escapeText(str) {
	if (typeof str !== "string") return "";
	return str
		.replace(/&/g, "&amp;")
		.replace(/</g, "&lt;")
		.replace(/>/g, "&gt;");
}

function escapeAttr(str) {
	if (typeof str !== "string") return "";
	return str
		.replace(/&/g, "&amp;")
		.replace(/"/g, "&quot;");
}

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

			const impl = new DOMImplementation();
			const doc = impl.createDocument(null, null, null);

			// Expose DOM globals for xslt-processor
			const originalDocument = global.document;
			const originalDOMParser = global.DOMParser;

			global.document = doc;
			global.DOMParser = DOMParser;

			let html;
			try {
				const parser = new DOMParser();
				const xslDoc = parser.parseFromString(xslText, "application/xml");
				const xmlDoc = parser.parseFromString(inputContent, "application/xml");

				const processor = new XSLTProcessor();
				processor.importStylesheet(xslDoc);

				const fragment = processor.transformToFragment(xmlDoc, doc);
				html = serializeToHTML(fragment);

				if (!html.startsWith("<!DOCTYPE")) {
					html = "<!DOCTYPE html>\n" + html;
				}
			} finally {
				global.document = originalDocument;
				global.DOMParser = originalDOMParser;
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