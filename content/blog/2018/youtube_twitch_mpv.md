---toml
date = "2018-05-08T19:47:22-04:00"
title = "Watching YouTube and Twitch with MPV"

---

My biggest annoyance with my Ubuntu 16.04 Linux laptop is that watching a video in a web browser takes way too much CPU. Maybe it's because I use a high-DPI display, maybe it's the version of Unity that I'm using, I can't tell. I've tried tweaking obscure Google Chrome options to enable hardware acceleration and installed extensions to force YouTube to use H.264, with little to no difference. I've also tried using other web browsers like the latest Firefox.

All the while, the [MPV](https://mpv.io/) video player, a descendent of MPlayer, played any video I've thrown at it will little CPU usage and with full hardware acceleration. What if I could stream at least YouTube and Twitch directly to it?

## Twitch

For Twitch, there is a command-line Python 3 tool called [Streamlink](https://streamlink.github.io/) that can lauch MPV for many video streaming web sites, including Twitch.

```bash
$ sudo -H pip install streamlink
$ streamlink --player mpv https://www.twitch.tv/PreviouslyRecorded_Live best
```

For a nicer GUI experience to find and view Twitch streams, you can install [Streamlink Twitch GUI](https://streamlink.github.io/streamlink-twitch-gui/). It also makes it easy to launch both the video and the chat room of a stream, and get notifications when a channel you follow goes live. Make sure to select MPV in the settings of the GUI if you prefer it over VLC (like I do).

## YouTube

For YouTube, I found the [mps-youtube](https://github.com/mps-youtube/mps-youtube) tool. It is designed to play YouTube music video playlists, but you can enable video display and play individual video pages.

In my tests, version 0.2.7 worked well for me, though later versions had issues.

```bash
$ sudo -H pip install youtube-dl mps-youtube==0.2.7
$ mpsyt
> set show_video true
> exit
$ mpsyt playurl https://www.youtube.com/watch?v=wcnBl6gNIhQ
```
