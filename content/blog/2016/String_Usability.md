---toml
date = "2016-12-26T10:11:21-05:00"
title = "On the Usability of Strings"

---

I've recently read an article about why programmers should favour Python 2 over Python 3 ("[The Case Against Python 3](https://web-beta.archive.org/web/20161123042252/https://learnpythonthehardway.org/book/nopython3.html)"), and most of it is an incoherent rant that expose the author's deep misunderstanding of how [bytecode](https://en.wikipedia.org/wiki/Bytecode) is internally used in scripting languages and how "market forces" of backwards-compatibility work against new languages. [Somebody else already rebutted](https://eev.ee/blog/2016/11/23/a-rebuttal-for-python-3/) those arguments better than I would do, and unlike the original author, his later edits are clear and doesn't involve "it was meant as a joke". One interesting a valid technical argument remains: Python 3's opaque support for Unicode strings can be unintuitive for those used to manipulate strings as transparent sequences of bytes.

Many programming languages came from an era where text representation was either for English, or for Western languages that would neatly fit all their possible characters in 8-bit values. Internationalization, then, meant at worst indicating what "[code page](https://en.wikipedia.org/wiki/Code_page)" or character encoding the text was. Having started programming on 90s Macintosh computers, the go-to string memory representation was the [Pascal string](https://en.wikipedia.org/wiki/String_%28computer_science%29#Length-prefixed), where its first byte indicated the string length. This meant that performing the wrong memory manipulation on the string, using the wrong encoding to display it, or even attempting to display corrupted memory would at worst display 255 random characters.

There is a strong argument that [UTF-8 should be used everywhere](http://utf8everywhere.org), and while it takes the occasion to educate programmers about Unicode (for more complete "Unicode for programmers", see [this article](https://www.joelonsoftware.com/2003/10/08/the-absolute-minimum-every-software-developer-absolutely-positively-must-know-about-unicode-and-character-sets-no-excuses/) and [this more recent guide](http://unicodebook.readthedocs.io)), doing so seems to conflate the two different design (and usability) issues: What encoding should be used to store Human-readable text, and what abstractions (if any) programming languages should offer to represent strings of text?

The "UTF-8 Everywhere" document already has [strong arguments for UTF-8 as the best storage format](http://utf8everywhere.org/#asian) for text, and looking at the popularity of UTF-8 in web standards, all that remains is to move legacy systems to it.

For strings in programming languages, you could imagine one that has absolutely no support for any form of strings, though it's difficult to sell the idea of a language that doesn't even support string literals or an ["Hello World" program](https://en.wikipedia.org/wiki/"Hello,_World!"_program). The approach of "UTF-8 Everywhere" is very close to that, and seems to indicate the authors' bias towards C and C++ languages: Transparently use UTF-8 to store text, and shift the burden of not breaking multi-byte code points back to the programmer. The argument that counting characters, or "grapheme clusters", [is seldom needed](http://utf8everywhere.org/#myth.strlen) is misleading: Splitting a UTF-8 string in the middle of a code point *will* break the validity of the UTF-8 sequence.

In fact, it can be argued that programming languages that offer native abstractions of text strings not only give greater protection against accidentally building invalid byte representations, but also give them a chance to do a myriad of other worthwhile optimizations. Languages that presents strings as immutable sequences of Unicode code points, or that transparently use [copy-on-write](https://en.wikipedia.org/wiki/Copy-on-write) when characters are changed, can optimize memory by de-duplicating identical strings. Even if de-duplication is done only for literals (like Java), it can greatly help with memory reuse in programs that process large amount of text. The internal memory representation of strings can even be optimized for size based on the biggest code point used in it, like [Python 3.3 does](http://pyvideo.org/pycon-us-2013/the-guts-of-unicode-in-python.html).

Of course, the biggest usability issue with using abstracted Unicode strings is that it forces the programmer to explicitly tell how to convert a byte sequence in a string and back. The article "The Case Against Python 3" above mentioned that the language's runtime should automatically detect the encoding, but that is highly error-prone and CPU intensive. The "UTF-8 Everywhere" argues that since both are using UTF-8, it boils down to memory copy, but then breaking code points is still a risk so you'll need some kind of UTF-8 encoder and parser.

I personally prefer the approach of most modern programming languages, including Perl, Python 3, Java, JavaScript and C#, of supporting both a string and "char" type, and force the programmer to explicitly mention the input and output encoding when converting to bytes. Because they are older and made when they naively thought that the biggest code point would fit in 2 bytes, meaning before these days of [Emojis](https://en.wikipedia.org/wiki/Emoji), Java and JavaScript use UTF-16 and 2-bytes characters, so they still can let you accidentally break 3 or 4-bytes code points. Also, it would be nice to do like C# and by default assume that the default encoding used when decoding or encoding should be UTF-8, instead of having to explicitly say so each time like in Perl 5 and Java. Still, providing those string and "char" abstractions while using UTF-8 as its default byte representation reduces the burden on programmers when dealing with Unicode. Sure, learning about Unicode code points and how UTF-8 works is useful, but shouldn't be required from novice programmers that write a "Hello World" program that outputs an Unicode Emoji to a text file.