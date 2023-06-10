---toml
date = "2017-03-18T20:24:21-04:00"
title = "My Ubuntu Tips"

---

Now that I've used a Ubuntu Linux laptop for a couple of months, I've realized that in day-to-day use I don't have to use much, if any, arcane commands on the command-line. And while I can edit the source code to fix bugs myself (and I did for the [duplicity backup tool](https://bugs.launchpad.net/duplicity/+bug/1672540)) or install software by compiling its source code, I rarely needed to do so. In fact, most of my customizations and installed software were straightforward.

## XPS 13 Specific Tips

For some unknown reason (licensing with Microsoft?), the "super" key (the one that still has the Windows logo) cannot be used to show the Ubuntu launcher by tapping the key. [As mentioned on the Ubuntu forums](https://ubuntuforums.org/showthread.php?t=2329091), to restore that functionality, simply remove the `dell-super-key` package.

When I use an external monitor, I typically use the internal screen at half its resolution and with a global UI scaling factor of 1, and without the external monitor I set it back to its native resolution with a UI scaling factor of 2. To do so on the command-line, without having to log out, I use these command. The external display is `DP1` and the internal one is `eDP1`. Note that the touch screen virtual mouse might be a bit confused until you log out. Also you may have to restart some programs, for them to pick up the scaling changes.

Half-res with scale of 1:

```bash
xrandr --output eDP1 --mode 1600x900 && \
gsettings set org.gnome.desktop.interface scaling-factor 1 && \
gsettings set com.ubuntu.user-interface scale-factor "{'DP1': 8, 'eDP1':8}"
```

Full-res with scale of 2:

```bash
xrandr --output eDP1 --mode 3200x1800 && \
gsettings set org.gnome.desktop.interface scaling-factor 2 && \
gsettings set com.ubuntu.user-interface scale-factor "{'DP1': 8, 'eDP1':16}"
```

I'm using the [Plugable USB-C Hub](http://plugable.com/products/ud-ca1/), and for some reason the drivers tend to get confused with the hub's network and audio ports if I just unplug the USB-C wire. To do a "clean eject" of the hub's internal 2 USB hubs, I run the following. You should use `lsusb -t` before and after connecting the hub to find the bus IDs in your setup.

```bash
sudo bash -c 'for i in 3 4 ; do echo 1 > /sys/bus/usb/devices/$i-1/remove ; done'
```

## GUI Themes

While there are countless GUI themes on Linux, the one I currently use is [Adapta](https://github.com/adapta-project/adapta-gtk-theme) with the [Noto fonts](https://github.com/googlei18n/noto-fonts). It mimicks the latest Android look, and while it's not a huge fan of the latest "Material" look, at least it avoids the ugly "orange everywhere" Ubuntu look.

To set it up [follow this guide](http://www.omgubuntu.co.uk/2016/10/install-adapta-gtk-theme-on-ubuntu). After that, install the packages `unity-tweak-tool`, `fonts-noto`, `fonts-noto-mono`, `fonts-noto-hinted` and `fonts-noto-cjk`, and finally use the Unity Tweak Tool to select Adapta as the theme and the various Noto fonts for the system fonts.

## Menu Indicators

In Ubuntu *parlance*, the menu bar items on the top-right are called "indicators". Any program can add indicators when launched, but "pure" indicator programs only need to be launched once and from then on they will automatically start each time you log in.

The `indicator-multiload` displays graphs of CPU load, I/O, network and so on.

The `indicator-cpuprefs` displays the current CPU frequency. Also, on some CPUs, you can select the specific frequency you want, or select the CPU "governor". For example, on my [Kaby Lake](https://en.wikipedia.org/wiki/Kaby_Lake) processor I can set it to "ondemand", "convervative", "performance" or "powersave".

The `my-weather-indicator` simply displays the current weather, and lets you view the weather forecast.

The `psensor` program tracks your system's various temperature sensors and when running adds a useful indicator menu with the current temperature.

## Great Apps

My currently favourite editor, [Visual Studio Code](https://code.visualstudio.com/) from Microsoft, is based on WebKit (similar to [Atom](https://atom.io/), but simpler and more lightweight), and is available as a Debian and Ubuntu package.

A beta version of [Skype for Linux](https://www.skype.com/fr/download-skype/skype-for-computer/), again from Microsoft (who knew?), is now available with both microphone and camera support.

[NixNote](http://nixnote.org/) is an open-source client for [Evernote](https://evernote.com/). It is generally more convenient to use than the Evernote web client, especially for offline use.

There is a [desktop application](https://github.com/egoist/devdocs-app/releases) for the [DevDocs](http://devdocs.io/) web site. It is a convenient way to search and read documentation for various programming languages and tools, even in offline more. I found it to be a compelling and often superior replacemnt to [Dash](https://kapeli.com/dash).

Ubuntu has a built-in screenshot tool, but for recording the screen as a video file or a GIF there is [Peek](https://github.com/phw/peek). It is a breeze to set up and use.

If you use Twitter, Corebird is a nice twitter client, and can be installed on Ubuntu by [following the instructions here](https://launchpad.net/~ubuntuhandbook1/+archive/ubuntu/corebird/).

## Other Tips

To open files or URLs from the command-like, you can use `xdg-open`. To view a `man` page in a GUI window, you can run `xdg-open man:crontab.5`.

The built-in VNC server is quite limited and doesn't support the better image compression techniques. Instead, you can use x11vnc by following [these instructions for Ubuntu](https://help.ubuntu.com/community/VNC/Servers#x11vnc).
