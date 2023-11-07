---toml
date = "2022-02-12T12:00:00-05:00"
title = "More Modern CLI Tools"

---

Since I last posted about some [modern-ish CLI tools](/blog/2021/09/18/modern-command-line-tools/), I noticed that I omitted many tools I extensively use and new ones I discovered since.

**[byobu](https://www.byobu.org/)**. This provides a consistent and user-friendly wrapper on top of either [GNU Screen](https://en.wikipedia.org/wiki/GNU_Screen) or [tmux](https://en.wikipedia.org/wiki/Tmux). With it, you can persist on a server some virtual terminals. It uses function keys to do most of its operations, and you can always use the original function keys by pressing "shift-F12". It comes with the useful `byobu-ugraph` that can simple histograms on the status bar using UTF-8 characters.

**[xh](https://github.com/ducaale/xh)**. This is yet another alternative to [HTTPie](https://httpie.org/), but rather than simply wrapping [curl](https://curl.haxx.se/), it implements a full HTTP client on its own. It is packaged as a single statically compiled binary, so it is easy to install and faster than HTTPie. If you symbolic-link it as `xhs`, it will automatically default to HTTPS.

**[btop++](https://github.com/aristocratos/btop)**. I was looking for a simple yet comprehensive monitoring tool I can use on the command-line to quickly look at CPU, process, memory, and disk usage. So far, this is my preferred one. While I still prefer [htop](https://htop.dev/) as a direct replacement of the `top` command, `btop` is quite easy to use without additional configuration, and again as a single static binary.

**[jo](https://github.com/jpmens/jo)**. This is a simple tool to generate valid JSON objects out of command-line parameters.

**[jq](https://stedolan.github.io/jq/)**. This is like `grep` or `sed`, but for JSON input. You can "query" any part of one or more JSON objects, and generate from that a result JSON fragment, or the plain text raw value. For example, the following uses the REST API of [ipify.org](https://www.ipify.org/) to get your IP address:

```sh
xhs api.ipify.org format==json | jq -r .ip
```
