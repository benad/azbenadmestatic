---toml
date = "2021-09-18T14:20:51-04:00"
title = "Modern Command-Line Tools"

---

Having used so many different Linux and UNIX-like environments, I started to really appreciate how useful it is to properly learn how to use the POSIX shell (and a few of the more standard GNU extensions). At some point though, typing convulated combinations of `find`, `grep`, `awk` and `sed` commands gets annoying.

In the past 10 years of so, the modern command-line environment is less worried about the UNIX philosophy of small tools built around plain text. And if they do use plain text, they tend to support structured formats like JSON. This means that they're more comfortable in fully using ANSI color codes and UTF-8 formatting when the output is done to the console. They also depend less on system libraries and are often large binaries, especially when built using Go or Rust.

Here are a few of my favorite modern tools I recently started to use. Of course, there are lots more, for example those listed in [ibraheemdev/modern-unix](https://github.com/ibraheemdev/modern-unix), but I limited my list to those I frequently use.

**[bash-git-prompt](https://github.com/magicmonty/bash-git-prompt)**. To be used specifically with Bash, this changes the shell prompt when you're inside a Git repository to display Git status information.

**[ripgrep](https://github.com/BurntSushi/ripgrep)** (command: `rg`). This tool is basically a recursive grep over many files. While GNU's grep does support a recursive option, ripgrep is easier to use, takes into account `.gitignore` files, supports UTF-8 automatically, supports many compression formats, has a better colorized output and is much faster.

**[bottom](https://github.com/ClementTsang/bottom)** (command: `btm`).  To quickly look at CPU and memory usage, both `top` and the more modern `htop` work quite well. But I would often also want to see other metrics, like network and disk usage in a cross-platform way, and without having to install some big system monitoring tool that runs all the time. `btm` displays all that, with some interactive graphs, fully colorized and interactive.

**[bat](https://github.com/sharkdp/bat)**. A `cat` replacement or a pager (like `more` and `less`), but that has many additional options and supports syntax highlighting of many file types. For example, it can be used as a pager for `man`, introducing color and UTF-8 characters to its output. It can easily be integrated with other tools, like `ripgrep`, using the scripts in [bat-extras](https://github.com/eth-p/bat-extras).

**[delta](https://github.com/dandavison/delta)**. A colorized viewer of `diff` and `git diff`, or can be used on its own to compare two files or directories. Its output displays per-character differences, which is greatly helpful when looking for whitespace-only changes. Also does syntax highliting, similar to `bat`.

**[broot](https://github.com/Canop/broot)** (command: `broot` or `br`). A file navigation interface that makes finding a file in a complex directory structure as simple and quick as possible. It include a file previewer that also works with image files. The `br` command is actually a shell function that you can install (for example in `.bashrc`) that makes it possible to run a command on the selected file in the current shell after `broot` exits. Customization of the "run a command in the shell after exit" can be a bit difficult; Look at [my sample configuration file](https://gist.github.com/benad/6cb229670a667adf1f2926fd4097c6c6#file-conf-hjson) as an example.

**[curlie](https://curlie.io/)**. While I really like [HTTPie](https://httpie.org/)'s command-line syntax, it's still a slow and heavy Python 3 script. Curlie lets you use the HTTPie syntax but runs using [curl](https://curl.haxx.se/) instead and reformats the output to make it similar to HTTPie. You can also get the equivalent `curl` command.
