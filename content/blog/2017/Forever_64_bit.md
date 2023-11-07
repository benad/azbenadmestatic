---toml
date = "2017-08-23T14:19:31-04:00"
title = "Forever 64-bit"

---

This web site is running with Debian Linux 7, so [in May it won't be supported anymore](https://www.debian.org/News/2016/20160212.en.html). I started making plans to move the server to Debian 8 or 9, when I noticed that all the Debian [OpenVZ](https://openvz.org/) templates offered by my hosting provider are [64-bit](https://en.wikipedia.org/wiki/64-bit_computing). At the time I chose a 32-bit Debian 7 VM since it has only 512 MB of RAM, but now I don't have a choice.

Is this my last 32-bit computer? OK, maybe that depends on your definition of "computer". [My watch](https://en.wikipedia.org/wiki/Apple_Watch) is [32-bit](https://en.wikipedia.org/wiki/Apple_S1), and so I suspect whatever crap Sony used in my "smart" TV, let alone those cheap processors in my printer, router, [lightbulbs](https://en.wikipedia.org/wiki/Philips_Hue)… But my phone, tablet, game console, computers of all kinds, they're all 64-bit.

I'm not entirely convinced that a 64-bit processor in a system with less than 4 GB of RAM is that useful. I've heard arguments that the additional virtual memory space can help security and that processing that requires lots of memory throughput is faster, but that still isn't that much compared to doubling the size of every memory pointer. In the case of this web site, the host computer is surely already 64-bit, so there could be significant performance degradation in running a 32-bit virtual machine in it.

Maybe the jump to 64-bit represents a final generational gap that is worth jumping over earlier than later. In my lifetime, I was born during 8-bit computing, and experienced the often difficult transitions between each doubling of memory space. They were so significant that early games consoles included their "bitness" in their names, such as the [TurboGrafx-16](https://en.wikipedia.org/wiki/TurboGrafx-16), [Sega 32X](https://en.wikipedia.org/wiki/32X) and [Nintendo 64](https://en.wikipedia.org/wiki/Nintendo_64).

And yet, with 64-bit, I don't expect such a gap to 128-bit in my lifetime, if ever. This isn't just a lack of vision, but rather plain math: 2^64 is about 18 billion GB, not of storage, but live RAM. At that point, moving directly to 128-but rather than some increment to something like 72-bit would just be wasteful.

What then should now be the measure of a "gap" in processing power? The number of cores? The transistor size? Even the clock rate was abandoned since it was an unreliable measurement of speed, and just being too technical for marketing.
