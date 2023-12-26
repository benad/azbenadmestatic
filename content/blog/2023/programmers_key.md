---toml
date = "2023-09-06T20:00:00-05:00"
title = "The Programmer's Key"
---

I recently discovered [Infinite Mac](https://infinitemac.org/), a web site that lets you emulate, within your web browser, old Macintosh systems. It does so by porting to WebAssembly some popular Mac emulators, including [SheepShaver](https://sheepshaver.cebix.net/) for Power Macintosh emulation.

With it, I was able to set up the software I used when I started programming in 1997. The setup (software and hardware) isn't identical to what I used on a Power Macintosh 6100, but it's close enough.

First, the compiler. For a long while, the "[Macintosh Programmer's Workshop](https://en.wikipedia.org/wiki/Macintosh_Programmer%27s_Workshop) ("MPW") was the "reference" compiler. It wasn't free (though I couldn't find any reference to how much it cost), and because Pascal was the preferred language of the Macintosh, C language support was limited. Years later it became free, but by that time there were much better compilers, with better PowerPC support, to the point that even programmers at Apple stopped using MPW.

I was recommended [Metrowerk](https://en.wikipedia.org/wiki/Metrowerks)'s [CodeWarrior](https://en.wikipedia.org/wiki/CodeWarrior) Pro, versions Pro 1 to Pro 3. Luckily, there is a [copy of CodeWarrior Pro 4 on archive.org](https://archive.org/details/cwpro4/). It can run directly from the CD-ROM, so it works perfectly in Infinite Mac.

The reference CD also came with some "introduction to programming" books. I used them to be introduced to C and C++, skipping entirely learning Pascal, because from I saw nobody else was using Pascal outside of Macintosh development.

Second, the references to the Macintosh APIs. The only official reference was the "[Inside Macintosh](https://en.wikipedia.org/wiki/Inside_Macintosh)" books. It was only available as expensive physical books, until 1995, when it was published on CD-ROM. There is a [copy of Inside Macintosh CD on archive.org](https://archive.org/details/Inside_Macintosh_CD-ROM_1995), which also works in Infinite Mac. The CD doesn't use PDF, using it's own "reader" software, and the figures are of very low quality, so if you want to read it, you should instead refer to the [Inside Macintosh PDF files on vintageapple.org](https://vintageapple.org/inside_r/).

So, you can look at the full environment on this [PowerMac G3 virtual machine](https://infinitemac.org/2000/Mac%20OS%209.0.4?saved_hd=true&cdrom=https%3A%2F%2Farchive.org%2Fdownload%2Fcwpro4%2FCW4MACTOOLS.ISO&cdrom=https%3A%2F%2Farchive.org%2Fdownload%2Fcwpro4%2FCW_PRO4_REF.ISO&cdrom=https%3A%2F%2Farchive.org%2Fdownload%2FInside_Macintosh_CD-ROM_1995%2FInside%2520Macintosh%2520CD-ROM_1995%2520%2528CD%2529.toast), with all the CD-ROMs I mentioned inserted in it.

Still, something important is missing: Being able to press on the "[Programmer's Key](https://en.wikipedia.org/wiki/Programmer%27s_key)" to launch [MacsBug](https://en.wikipedia.org/wiki/MacsBug). Every Macintosh until the end of the PowerMac G3 line had two hidden buttons on the back or on their side. The most commonly known one was the reset key, which was convenient considering how often you had to reboot Macs after a crash (and somehow the "Restart" button in the [system error alert](https://en.wikipedia.org/wiki/Bomb_%28icon%29) didn't work). The other button, the programmer's key, was often pressed by accident (when trying to reach out for the reset button) or by curiosity, which typically resulted in the user unfriendly [MicroBug](https://developer.apple.com/library/archive/technotes/tn/tn1136.html) to be displayed. The proper way to exit that prompt is either with the `G` command, or by executing `_ExitToShell` with `SM 0 A9F4` followed by `G 0`. Without any "help" command most users would panic and use the reset key anyway. Notice how a function can be executed by setting a value at memory position 0 and resuming execution there, which was possible due to the Macintosh (before Mac OS X) complete lack of [virtual](https://en.wikipedia.org/wiki/Virtual_memory), [protected memory](https://en.wikipedia.org/wiki/Memory_protection).

Installing and running SheepShaver, especially on Windows, wasn't a great experience. Not only you have to find Macintosh ROMs, but the emulation wasn't particularly stable, crashing more often than a real Mac. So, I looked to see if there was any other alternative. I then discovered that [QEMU](https://www.qemu.org/) added support for PowerPC emulation that worked with Mac OS. I followed the [instructions from Emaculation.com](https://www.emaculation.com/doku.php/ppc-osx-on-qemu-for-windows), and I was pleasantly surprised to see that everything worked right away (no ROM needed). This includes automatic networking support, so you can even use [Netscape Communicator](https://en.wikipedia.org/wiki/Netscape_Communicator) to transfer files from and to the host using FTP, or access TLS-less sites like [theoldnet.com](http://theoldnet.com/). Its support is more limited than SheepShaver (QEMU is using IDE drives for that, instead of SCSI, so you're limited to 1 or 2 CDs at a time), but it's still possible to [eject and swap the CD-ROM](https://www.linux-kvm.org/page/Change_cdrom).

But, more importantly I found in the Emaculation.com forums that [MacsBug was supported with the `nmi` command](https://www.emaculation.com/forum/viewtopic.php?p=60310). Technically, the programmer's key made the Mac motherboard execute a [Non-maskable interrupt](https://en.wikipedia.org/wiki/Non-maskable_interrupt), or "NMI". So, when running QEMU, you can switch to the monitor screen using control-alt-2, [enter the `nmi` command](https://www.qemu.org/docs/master/system/monitor.html?highlight=nmi), and go back to the computer's screen with control-alt-1 to see MicroBug, or MacsBug it its extension was installed.

To explain how powerful MacsBug was, it's the equivalent of pausing a virtual machine and inspecting or changing anything in the machine's physical memory, in addition to the CPU state. Because Macintosh didn't use any kind of [preemptive multitasking](https://en.wikipedia.org/wiki/Preemption_%28computing%29#PREEMPTIVE) or separation between [user and kernel space](https://en.wikipedia.org/wiki/User_space_and_kernel_space), executing a non-maskable interrupt effectively "paused" the entire computer, instantly. Not only this was great for debugging, but also it allowed me to pretty much reverse engineer any running software, and more importantly cheat in some video games.

In a way, knowing how to make use of the programmer's key and MacsBug was a "rite of passage" that made you a proper Mac programmer. In retrospect, this wasn't quite useful, since a few years later "classic Macintosh" was completely replaced by MacOS X, a full UNIX-like system, and even myself I would dual-boot the PowerMac into [Yellow Dog Linux](https://en.wikipedia.org/wiki/Yellow_Dog_Linux) or use [Sun Solaris](https://en.wikipedia.org/wiki/Oracle_Solaris) at my university. The days of pressing a hidden button on the computer to enter some "hacking mode" was quickly over.