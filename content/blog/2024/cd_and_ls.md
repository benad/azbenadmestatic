---toml
date = "2024-09-29T14:00:00-04:00"
title = "Change Directory and List"
---

On my Linux systems, I use `ls` and `cd` all the time. Sure, use can use some variations of those commands, like `ll` on Debian systems, which does `ls -alF --color=auto` (for [GNU Coreutils](https://www.gnu.org/software/coreutils/)), and defining your own functions that perform a `cd` command to your favourite locations. You could even define your own "cd then ls" command.

Even then, my main issue is about *navigation*. I would often navigate to some location by examining the available directories at one location, and then changing my directory there, incrementally, until I get to the full path I desired. While this can be done with a combination of `ls` and `cd` commands, some shells like BASH support path completion for any command-line argument: Pressing TAB completes the path item's name, and if ambiguous (up to a point in the item name), a second press of TAB shows the available disambiguations. This process of path completion can be annoying: It is case sensitive, requires to know the path element names by prefix, and each ambiguous completion results in a "bell" sound.

Surely there has to be a better way.

### Fuzzy Search with `fzf`

***TODO***

Control-t: Add file or directory as argument. Can select multiple arguments using Tab or Control-i.

Alt-c: Fuzzy cd

Control-r: History, but better

https://github.com/junegunn/fzf

https://junegunn.github.io/fzf/shell-integration/

Example with preview sidebar using `bat` and skip some folders like `.git`:

```
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
```

### The File manager `nnn` 

***TODO***

https://en.wikipedia.org/wiki/Midnight_Commander

https://en.wikipedia.org/wiki/DOS_Shell

https://en.wikipedia.org/wiki/File_manager#Orthodox_file_managers

https://github.com/jarun/nnn

Use `-p` option to act as file picker: https://github.com/jarun/nnn/wiki/Basic-use-cases#file-picker.

https://github.com/jarun/nnn/blob/master/misc/quitcd/quitcd.bash_sh_zsh





