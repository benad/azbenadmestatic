---toml
date = "2025-08-10T16:00:00-05:00"
title = "Git BASH: Home away from home"
---

As I [mentioned](/blog/2021/09/18/modern-command-line-tools/) [before](/blog/2022/02/12/more-modern-cli-tools/), I have a few modern CLI tools I regularly use in my Linux environments. So much so that I started to miss them in Windows.

To get a BASH shell, I simply install [Git on Windows](https://git-scm.com/). It is packaged with some variant of [mingw-w64](https://www.mingw-w64.org/), that shares some similarities and tools with [Cygwin](https://cygwin.com/). When installing Git, I make sure to select the installation option to add a profile to [Windows Terminal](https://learn.microsoft.com/en-us/windows/terminal/), since mingw's terminal lacks support for modern UTF-8.

Luckily for me, most of the tools I wanted are now available as Windows binaries. This means that they can be used anywhere, not constrained to only BASH (or Cygwin).

Also, over time they became available through [Windows' Package Manager](https://learn.microsoft.com/en-us/windows/package-manager/) (`winget`). This means I can install all of them with the following command in PowerShell:

```ps1
"Git.git", "BurntSushi.ripgrep.MSVC", "sharkdp.bat",
"junegunn.fzf", "ducaale.xh", "dandavison.delta", "sharkdp.fd"
| foreach { winget install --id $_ }
```

I then put the following in my `~/.bashrc`:

```sh
rgd() { command rg --json -C 2 "$@" | command delta; }
xhs() { command xh --https "$@" ; }

export BAT_STYLE=plain
export BAT_THEME=ansi
export BAT_PAGING=always
eval "$( fzf --bash )"
export FZF_DEFAULT_OPTS="--walker=file,dir,follow --walker-skip .git,node_modules,target"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_ALT_C_OPTS="--walker=dir,follow --preview 'ls -1 --color=always {}'"
export FZF_DEFAULT_COMMAND='fd --type f --color=never -H --exclude .git --exclude node_modules'
```

Here's a quick overview of those tools:

[bat](https://github.com/sharkdp/bat) is a [terminal pager](https://en.wikipedia.org/wiki/Terminal_pager) that supports file syntax coloring and many more options. I've set some environment variables to change it's default style to be more compatible and to always run paging even when the terminal's size is big enough to display the entire input's contents.

[delta](https://dandavison.github.io/delta/) is another terminal pager specialized to show file differences, like `diff`. I've set up Git to use `delta` as the default pager, with the [side-by-side view](https://dandavison.github.io/delta/side-by-side-view.html), like this: `git config set --global core.pager "delta -s"` .

[ripgrep](https://github.com/BurntSushi/ripgrep) is a fast replacement for `grep -r`. I've made an alias `rgd` that pipes ripgrep's output to `delta` but with 2 lines of "context", giving a chance for delta to add file-specific syntax coloring to its output.

[fd](https://github.com/sharkdp/fd), also called `fdfind` in some package managers, is a simpler, more modern alternative to the old `find` command.

[fzf](https://junegunn.github.io/fzf/) is a "fuzzy finder". I've set it up so that by default it lists the output of a `fd` command that excludes folders named `.git` and `node_modules`. In BASH, it enhances the Control-r history search command, adds the Control-t command to insert a file argument to a command, and adds Alt-c to fuzzy search and change to a directory. I've customized it to use `bat` or `ls` to show a live preview. See [Shell Integration](https://junegunn.github.io/fzf/shell-integration/) for more details.

[xh](https://github.com/ducaale/xh) is an alternative to Curl designed for REST-like HTTP services. I've aliased `xhs` to make it assume HTTPS by default: For example, `xhs httpbun.org/post a=b` will use `https://httpbun.org/post`.

Of course there are more tools that can be installed in the same manner, for example `jq`, but this is enough to make Windows feel like my "home away from home".