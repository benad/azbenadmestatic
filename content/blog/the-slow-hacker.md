---toml
date = "2022-09-07T15:00:00-04:00"
title = "The Slow Hacker"

---

Being an early adopter of new technologies and tools can be exiting. Recently, I've jumped into some new tools, hacking around to make them work, just to realize that by the time I made it work, a better version that doesn't require so much hacking is released. Here are a few examples.

## Bluetooth Audio Codecs on Linux

I have bluetooth headphones from different brands, and while all of them support the common [SBC codec](https://en.wikipedia.org/wiki/SBC_%28codec%29), they also each support some better format, like [AAC](https://en.wikipedia.org/wiki/Advanced_Audio_Coding), [aptX](https://en.wikipedia.org/wiki/AptX) or [LDAC](https://en.wikipedia.org/wiki/LDAC_%28codec%29). I was a bit saddened to see that, out of the box, Ubuntu 20.04 supported only the basic SBC codec. Looking around, I found the article "[Improving Bluetooth Audio Quality on Ubuntu Linux](https://kn100.me/improving-bluetooth-audio-linux/)" that describes how to install those additional codecs. This is a bit risky, as this could potentially mess up the audio stack.

There was a fork of [pulseaudio-modules-bt](https://github.com/EHfive/pulseaudio-modules-bt) that came with all those Bluetooth codecs, and there is a way to replace the built-in Ubuntu's version with this. Once installed, the audio settings panel clearly shows the audio codec being used for your headphones, and you can even try to select another codec.

I said "was" because, by the time I started using it, its documentation already mentioned that it was "deprecated". Why? Because the additional codecs are now supported in the mainline version of PulseAudio. Sure, there are some delays between when a new feature is added to a package and when that packaged is incorporated into a new major release of Ubuntu, but Ubuntu 22.04 already included that new version. In fact, it is mentioned in its [release notes](https://ubuntu.com/blog/ubuntu-22-04-lts-whats-new-linux-desktop): "PulseAudio delivers a number of improvements for Bluetooth headsets, with support for a wider range of devices and battery level reporting".

So, yeah, instead of patching PulseAudio in Ubuntu 20.04, I could have just upgraded to Ubuntu 22.04.

## Using Linux GUI Apps in WSL

Back on Windows, I still end up using a lot Linux through the "[Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/)". Unlike a full Linux virtual machine, it doesn't start a desktop environment, or even start systemd. While this means that it is very lightweight, it also means that running an X11 application can be difficult.

As an example, starting an SSH server so that you can do X11 forwarding (as in `ssh -X ...`) has to be done manually every time you start the WSL "distribution". And then I needed to figure out what kind of "rootless" X11 client I can use on Windows...

Another option I found was to run a full Linux desktop in WSL in a VNC server, all running inside of a special systemd environment. While [this document](https://gist.github.com/tdcosta100/385636cbae39fc8cd0937139e87b1c74) describes the process, it's not very user-friendly. It makes use of [genie](https://github.com/arkane-systems/genie), a tool that will run the systemd environment in WSL. The obvious downside to all this is that, well, it takes almost as much memory as running a full Linux virtual machine, negating a bit the point of using WSL in the first place.

Well, I could have just waited for the latest versions of Windows 11. The document "[Run Linux GUI apps on the Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/tutorials/gui-apps)" describes the process, and it's very easy to use. If you're already on version 22000 or higher (and up-to-date video drivers), there's nothing else to install, other than installing the Linux apps themselves. Impressively, it fully supports UI scaling, and even dynamic UI scaling with newer GTK apps if you move the window between differently scaled monitors. It even supports adding the `*.desktop` shortcuts in the Start menu.

## Podman on Windows

I really like [Podman](https://podman.io/), not only as a fully open-source alternative to Docker, but also for its unique features. And I also intensely dislike [Docker Desktop](https://www.docker.com/products/docker-desktop/), which is *not* open source and is quite buggy. So, I wondered if there was a way to use Podman on Windows and tried installing it inside my Ubuntu distribution in WSL, set up the SSH connection so that I can use it "remotely" from Windows' command line, and so on.

Well, it just so happens that there is now a [version of Podman for Windows](https://www.redhat.com/sysadmin/run-podman-windows). Not only that, but there is an early version of "Podman Desktop", which makes installing and using Podman much more "graphical".

The only thing that prevented it for me from being an almost direct replacement of Docker is its policy about ["image short names" not defaulting to Docker Hub by default](https://www.redhat.com/sysadmin/container-image-short-names). I fixed it like this:

```
podman machine ssh
sudo sed -i.backup 's/^short-name-mode=.*/short-name-mode="permissive"/' /etc/containers/registries.conf
exit
```
