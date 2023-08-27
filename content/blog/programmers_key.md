---toml
date = "2023-09-01T00:00:00-05:00"
title = "The Programmer's Key"
---

I recently discovered [Infinite Mac](https://infinitemac.org/), a web site that lets you emulate, within your web browser, old Macintosh systems. It does so by porting to WebAssembly some popular Mac emulators, including [SheepShaver](https://sheepshaver.cebix.net/) for Power Macintosh emulation.

With it, I was able to set up the software I used when I started programming in 1997. The set up (software and hardware) isn't identical to what I used on a Power Macintosh 6100, but it's close enough.

First, the compiler. For a long while, the "[Macintosh Programmer's Workshop](https://en.wikipedia.org/wiki/Macintosh_Programmer%27s_Workshop) ("MPW") was the "reference" compiler. It wasn't free (though I couldn't find any reference to how much it cost), and because Pascal was the prefered language of the Macintosh, C language support was limited. Years later it became free, but by that time there were much better compilers, with better PowerPC support, to the point that even programmers at Apple stopped using it.

I was recommended [Metrowerk](https://en.wikipedia.org/wiki/Metrowerks)'s [CodeWarrior](https://en.wikipedia.org/wiki/CodeWarrior) Pro, versions Pro 1 to Pro 3. Luckilly, there is a [copy of CodeWarrior Pro 4 on archive.org](https://archive.org/details/cwpro4/). It can run directly from the CD-ROM, so it works perfectly in Infinite Mac.

The reference CD also came with some "introduction to programming" books. I used them to be introduced to C and C++, skipping entirely learning Pascal, because from I saw nobody else was using Pascal outside of Macintosh development.

Second, the references to the Macintosh APIs. The only official reference was the "[Inside Macintosh](https://en.wikipedia.org/wiki/Inside_Macintosh)" books. Again, it wasn't free, and until 1995, when it was published on CD-ROM, it was only available as expensive physical books. There is a [copy of Inside Macintosh CD on archive.org](https://archive.org/details/Inside_Macintosh_CD-ROM_1995), which also works in Infinite Mac. The CD doesn't use PDF, using it's own "reader" software, and the figures are of very low quality, so if you want to read it, you should instead refer to the [Inside Macintosh PDF files on vintageapple.org](https://vintageapple.org/inside_r/).

So, you can look at the full environment on this [PowerMac G3 virtual machine](https://infinitemac.org/2000/Mac%20OS%209.0.4?saved_hd=true&cdrom=https%3A%2F%2Farchive.org%2Fdownload%2Fcwpro4%2FCW4MACTOOLS.ISO&cdrom=https%3A%2F%2Farchive.org%2Fdownload%2Fcwpro4%2FCW_PRO4_REF.ISO&cdrom=https%3A%2F%2Farchive.org%2Fdownload%2FInside_Macintosh_CD-ROM_1995%2FInside%2520Macintosh%2520CD-ROM_1995%2520%2528CD%2529.toast), with all the CD-ROMs I mentioned inserted in it.

Still, something important is missing: Being able to press on the "[Programmer's Key](https://en.wikipedia.org/wiki/Programmer%27s_key)" to launch [MacsBug](https://en.wikipedia.org/wiki/MacsBug).

## TODO

Programmer's Key: Available on all Macs up to and including G3. Some early Macs needed some dongle to access the button on the motherboard.

https://en.wikipedia.org/wiki/Non-maskable_interrupt

MicroBug: https://web.archive.org/web/20141113174222if_/http://www.fenestrated.net/~macman/mirrors/Apple%20Technotes%20(As%20of%202002)/tn/pdf/tn1136.pdf , https://developer.apple.com/library/archive/technotes/tn/tn1136.html 

https://en.wikipedia.org/wiki/Memory_protection

https://en.wikipedia.org/wiki/Preemption_(computing)#PREEMPTIVE

https://en.wikipedia.org/wiki/User_space_and_kernel_space

https://en.wikipedia.org/wiki/Virtual_memory

CodeWarrior had a MacsBug macro that allowed to fall back to its graphical debugger.

https://www.qemu.org/

https://www.emaculation.com/doku.php/ppc-osx-on-qemu-for-windows

https://www.linux-kvm.org/page/Change_cdrom

https://www.qemu.org/docs/master/system/monitor.html?highlight=nmi

Use control-alt-2 to go to the QEMU monitor. Type it again, or use control-alt-1 to go back to the computer's screen.

http://theoldnet.com/