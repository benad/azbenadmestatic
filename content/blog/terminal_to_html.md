---toml
date = "2019-04-11T17:51:06-04:00"
title = "Saving the Terminal to HTML"

---

When copy-pasting some text from my terminal to an email, I'm often annoyed that all I get is the text, losing all the [ANSI colors and formatting](https://en.wikipedia.org/wiki/ANSI_escape_code). If you're using a newer release of the GNOME desktop, for example Ubuntu 18.04, you'll notice that when right-clicking in its Terminal, you can use "Copy as HTML". But what if you want that HTML formatting for terminal output in other environments?

Originally, I was looking for something that would format the ANSI formatting of logs produced by [GNU Screen](https://www.gnu.org/software/screen/), or with the `script` command. Many commands that support ANSI formatting also support forcing that ANSI output to a file, though you may have to "force" it, for example `ls -l --color=always`. For displaying those logs to your terminal while "replaying" the ANSI control characters, `less -RX` works great, though I was looking for a way to "export" that in an email or text document.

The small tool [aha](https://github.com/theZiz/aha), the "Ansi HTML Adapter", does the trick perfectly. Pipe in your ANSI formatted log, and it will pipe out a nicely formatted HTML document.

Now, ANSI control characters do a lot more than just formatting colors and font weight. It can effectively redraw any character on the terminal screen using absolute positioning, which allows things like Vim or countless programs using the [ncurses](https://en.m.wikipedia.org/wiki/Ncurses) library. Or it could be as simple as a progress bar, or just pressing backspace. In those scenarios, what I'd like to copy is a kind of "video" of the Terminal interaction, including "timing", something that the previously mentioned GNO screen and `script` can't do.

For that, you can use [asciinema](https://asciinema.org/). You can start a recording with `asciinema rec myrecording.cast`, and end it with the `exit` command. To play it back, you can use `asciinema play myrecording.cast`. You can embed your recording `myrecording.cast` on a web page "video player" interface using [asciinema-player](https://github.com/asciinema/asciinema-player). If you want to export that to some a video or GIF, you can play it back in a terminal using something like `clear ; asciinema play myrecording.cast` and using a screen recorder. My screen recorder of choice on Ubuntu is [Peek](https://github.com/phw/peek), as it's simple to use and even supports recording to GIF (in addition to MP4 and OGG).
