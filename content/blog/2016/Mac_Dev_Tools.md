---toml
date = "2016-08-16T19:44:10-04:00"
title = "Mac-Only Dev Tools"

---

Even though I use Macs, Linux and Windows machines daily and could switch to any of these exclusively, I prefer running my Mac alongside either Linux or Windows. A reason I do so is that there are some development tools that run exclusively on macOS that I prefer over their other platforms' equivalents. Here are a few I use regularly.

To be fair, I'll also list for each of those tools what I typically use to replace these on Windows or Linux.

**BBEdit**

While [BBEdit](http://www.barebones.com/products/bbedit/) isn't as flexible or extensible as [jEdit](http://www.jedit.org/), [Atom](https://atom.io/), [Emacs](https://www.gnu.org/software/emacs/), or even [Vim](http://www.vim.org/) to some extent, BBEdit feels and act the most as a proper *native* Mac text editor. It is packed with features, is well supported, and is incredibly fast. It works quite well with [SFTP](https://en.wikipedia.org/wiki/SSH_File_Transfer_Protocol), so I often use it to edit remote files. It also is the editor I used the longest, as I used it since the late 90s.

*Alternatives* : Too many to mention, but I currently prefer [Visual Studio Code](http://code.visualstudio.com/) on the desktop and vim on the command-line.

**CodeKit**

[CodeKit](http://incident57.com/codekit/), which [I mentioned before](https://benad.me/blog/2014/8/14/client-side-javascript-modules/), is my "go to" tool to bootstrap my web development. It sits in the background of your text editor (any one you want) and web browsers, and automatically validates and optimizes your JavaScript code and CSS files to your liking. It also supports many languages that compile to JavaScript or CSS, like [CoffeeScript](http://coffeescript.org/) and [SASS](http://sass-lang.com/).

*Alternative* : Once I move closer to production, I do end up using [Grunt](http://gruntjs.com/). You can set it up to auto-rebuild your site like CodeKit using [grunt-contrib-watch](https://www.npmjs.com/package/grunt-contrib-watch), but Grunt isn't as nearly user-friendly as CodeKit.

**Paw**

[Paw](https://luckymarmot.com/paw/) quickly became my preferred tool to explore and understand HTTP APIs. It is used to build up HTTP requests with various placeholder variables and then explore the results using multiple built-in viewers for JSON. All your requests and their results are saved, so it's safe to experiment and retrace your way back to your previously working version. You can also create sequences of requests, and use complex authentication like [OAuth](https://en.wikipedia.org/wiki/OAuth). When you're ready, it can generate template code in multiple languages, or [cURL](https://en.wikipedia.org/wiki/CURL) commands.

*Alternative* : I like using [httpie](http://httpie.org/) for the HTTP requests and [jq](https://stedolan.github.io/jq/) to extract values from the JSON results.

**Dash**

When I was learning Python 3, I constantly made use of [Dash](https://kapeli.com/dash) to search its built-in modules. It can do I incremental search in many documentation packages and cheat sheets, and does so very quickly since it is done offline. It also make reading "man" pages much more convenient.

*Alternatives* : There's Google, of course, but I prefer using the custom search engine of each language's documentation site using the DuckDuckGo "[bang syntax](https://duckduckgo.com/bang?c=Tech)".
