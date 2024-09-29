---toml
date = "2024-09-29T11:15:00-04:00"
title = "Change Directory and List"
---

On my Linux systems, I use `ls` and `cd` all the time. Sure, use can use some variations of those commands, like `ll` on Debian systems, which does `ls -alF --color=auto` (for [GNU Coreutils](https://www.gnu.org/software/coreutils/)), and defining your own functions that perform a `cd` command to your favorite locations. You could even define your own "cd then ls" command.

Even then, my main issue is about *navigation*. I would often navigate to some location by examining the available directories at one location, and then changing my directory there, incrementally, until I get to the full path I desired. While this can be done with a combination of `ls` and `cd` commands, some shells like [BASH](https://en.wikipedia.org/wiki/Bash_%28Unix_shell%29) support path completion for any command-line argument: Pressing TAB completes the path item's name, and if ambiguous (up to a point in the item name), a second press of TAB shows the available disambiguation. This process of path completion can be annoying: It is case sensitive, requires knowing the path element names by prefix, and each ambiguous completion results in a cacophony of "bell" sounds (or some stroboscopic "visual bell").

Surely there has to be a better way.

### Fuzzy Searching with `fzf`

[fzf](https://github.com/junegunn/fzf) is a "fuzzy finder" that can search for files in real time as you type part of their paths. It can also be used for looking for directories, or to search matching lines from any input.

In some shells like BASH, fzf can [add a few useful keyboard shortcuts](https://junegunn.github.io/fzf/shell-integration/). `alt-c` is a replacement for `cd`. `control-t` can be used to insert one or more paths that were found using `fzf` on the current command-line. Due to its support for searching in any input text, `control-r` replaces BASH's built-in history search with fuzzy search, which is incredibly useful if you can't exactly remember a command from your command history.

`fzf` also supports showing a preview pane for the currently selected entry. For example, this can be used to show the output of the `ls` command of the selected directory when you use `alt-c`:

```sh
export FZF_ALT_C_OPTS="--preview 'ls {}'"
```

`fzf` can be used with any other process' output. For example, [fzf-git](https://github.com/junegunn/fzf-git.sh), from the same author, supports fuzzy searching for Git objects, like branch names or file paths known to Git, and inserts the result on the command-line.

### The n<sup>3</sup> File Manager

So, while `fzf` helps with finding specific files, it isn't a replacement for file system navigation. You still need to display the files in the current directory, and performing file operation across multiple directories lacks visualization.

There has been file managers in a command-line environments for a *long* time. For [DOS](https://en.wikipedia.org/wiki/DOS) there were quite a few text-based graphical file managers, like [Midnight Commander](https://en.wikipedia.org/wiki/Midnight_Commander) or [DOS Shell](https://en.wikipedia.org/wiki/DOS_Shell).

A more modern file manager I use is [n<sup>3</sup>](https://github.com/jarun/nnn), named `nnn` on the command-line. It differs from what are called ["orthodox" file managers](https://en.wikipedia.org/wiki/File_manager#Orthodox_file_managers), in that it displays only one directory at a time, and generally avoids using "graphical" display. It keeps track of up to 4 different contexts, which are either a directory or a list of files that was output by another process or from its extensive support for plugins.

Navigation in n<sup>3</sup> is as simple as using the arrow keys, and it supports [changing the current directory on exit](https://github.com/jarun/nnn/blob/master/misc/quitcd/quitcd.bash_sh_zsh). Its interface is light, but it displays a handy keyboard shortcut reference when pressing `?`.

It can also be used as a "file picker" [using the `-p` option](https://github.com/jarun/nnn/wiki/Basic-use-cases#file-picker), acting in a way as an alternative to `fzf`.





