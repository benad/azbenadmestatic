---toml
date = "2017-11-06T20:02:16-05:00"
title = "Raspberry Pi: Your Home Linux Server"

---

Looking at the [Raspberry Pi web site](https://www.raspberrypi.org/), you'd think that this small Linux-based computer is only useful for robotics and STEM activities for kids. And yet, for the past few months I've been using it as my home Linux server.

I've been looking for a long time for a small "embedded" server I could use as a hub for my home appliances, and something that stays on so that I can "phone home" remotely. Sure, I could recycle an old PC or laptop, but that would be too noisy or take too much electricity. Even the small [Intel "compute sticks"](https://en.wikipedia.org/wiki/Intel_Compute_Stick) have small fans, and it's unclear if they can support Linux at all.

The Pi is not only cheap (about $40), but runs Linux, is completely fanless and takes little electricity. In my own tests,  it takes between 240 mA (HDMI off) and 270 mA (HDMI on) on a USB 2 5.1V connection, effectively making it use less power than a sleeping Mac mini (1.22 W vs 1.25 W as per its [environmental report](https://www.apple.com/environment/reports/docs/Macmini_PER_feb2014.pdf)). As a result, I leave all my devices in standby or sleep mode, and use the Pi to remotely power on devices using [WoL packets](https://en.wikipedia.org/wiki/Wake-on-LAN).

The Pi runs off a micro SD card, making it easy to swap it out with another Linux system or backup. It supports many Linux distributions, and its main supported one, [Raspbian](https://www.raspberrypi.org/downloads/raspbian/), is based on the latest Debian 9 "stretch". It comes built-in with Python 3 and `gcc`, so it is easy to install Python modules from Debian itself, or compile them using `pip3`. Running a small Python web service on it has been a breeze.

If you're unfamilliar with Linux, Python or programming in general, don't worry, the Pi was tailored for schools. It has a full graphical desktop, and several tools to learn programming like [Scratch](https://scratch.mit.edu/), [thonny](http://thonny.org/), and various STEM-related tools.

Sure, its 1 GB of RAM makes browsing the web with it slow and limited, while its shared USB 2 bandwidth makes it slow as a large file server or media center, but otherwise it can do a lot, for very cheap. If you want to learn about programming or web server development on Linux, and use that to do cool things in your house, with very little risk, the Raspbian Pi is for you.
