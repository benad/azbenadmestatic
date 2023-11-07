---toml
date = "2018-01-09T16:59:18-05:00"
title = "Raspberry Pi as a DVR"

---

As I mentioned in [a previous post](https://benad.me/blog/2017/11/06/raspberry-pi-your-home-linux-server/), I started using my Raspberry Pi as my "always on" home server. This allowed my to place my other devices into either standby mode or shut down, and power them on using the Pi only when needed.

It just so happens that one of the devices was my [Plex](https://www.plex.tv/) media server. As I already have an Antenna and a TV tuner (the [HDHomeRun Extend](https://www.silicondust.com/product/hdhomerun-extend/)), in addition to the "[Plex Pass](https://www.plex.tv/features/plex-pass/)", I wanted to use my Plex server to record Over The Air (OTA) TV shows, when I ran into the problem that my server was in standby most of the time and would miss its recording schedule. Sure, this is a seemingly important missing feature of the [Plex DVR](https://www.plex.tv/features/live-tv-dvr/), but I guess I could write some scheduled script on the Pi to wake up the Plex server just before recording happens. Or what if I could just run a Plex server on the Pi just to record TV shows?

So I connected one of my spare portable USB drive to the Pi, installed a Pi version of Plex following the instructions on the [dev2day](https://dev2day.de/projects/) site, and it worked! Sure, the primary limitation of the Pi compared to a PC, and why I won't move my main Plex server's content to the Pi, is its very limited CPU, to the point where all form of transcoding should be avoided. For OTA recordings, the format is typically MPEG-2 or MP4 for the video, and typically AC3 for the audio. On most devices there is a built-in AC3 decoder, including the Apple TV 4th Generation, the LG TV app and the iPad Air 2, so no transcoding was needed. On my iPhone SE the AC3 decoder didn't work (I even tested with the [VLC app](https://www.videolan.org/vlc/download-ios.html)), and the transcoder on the Pi was just too slow for a smooth playback. And, of course, playing back the recording from the Pi itself on HDMI is far too slow.

If you combine an antenna, the HDHomeRun Extend, maybe some network switch (depending on setup and how many spare ports you have on your router), the Rasperry Pi, a low-power portable USB drive, the Plex Pass and finally an Apple TV, you have a complete and quite low-power OTA TV DVR solution and "cutting the cord" solution. Sure, it could be cheaper if you replace the Apple TV with something else (Does the Roku have AC3 decoding? Or maybe use your "Smart TV" Plex app), but for sure the overall experience is much better than whatever crap you get with your cable provider's DVR.

