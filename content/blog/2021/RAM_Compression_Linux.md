---toml
date = "2021-02-23T18:31:39-05:00"
title = "RAM Compression on Linux"

---

I recently updated my 2013 MacBook Air to macOS "Big Sur" 11.1. I was nervous about what could be the last supported version of macOS for that laptop, and even then I wasn't sure the update would be successful, all that because it has only 4 GB of RAM. A ridiculously small amount, considering the bloat of modern web sites and web browsers. And yet, that laptop still runs fine, in no small part with how well macOS can do RAM compression. I wondered if my Raspberry Pi 3 (1 GB of RAM) and my small Ubuntu virtual machine (4 GM of RAM) could use a similar kind of RAM compression under Linux.

Linux has a kind of "RAM disk", actually a RAM-backed block device, that compresses the data prior to storing the data in memory. It is called [zram](https://www.kernel.org/doc/html/v5.3/admin-guide/blockdev/zram.html), surely because it defaults to [lzo compression](https://en.wikipedia.org/wiki/Lempel%E2%80%93Ziv%E2%80%93Oberhumer), one of a handful of compression techniques used for their speed. zram has been available by default in the Linux kernel for years, so there is no need to compile a custom kernel or add it as a kernel module.

While this doesn't *directly* solves the issue of compressing existing RAM, its nature as a block device makes it possible to add a zram device as a swap device. On Linux, you can have multiple swap devices or files, ordered by priority, so you could add a zram device as a higher priority than your disk-based swap devices. That way, if the kernel needs to swap some memory out, it will first try to move existing RAM into the zram-compressed RAM, and only when that fills up it will resort to use the disk. So while this technique won't compress the *existing* RAM usage, at least you could reserve let's say half of the RAM to the zram device, effectively using RAM compression for that half at a lower priority.

A good example on how to set up zram is in the [zram-config](https://launchpad.net/ubuntu/+source/zram-config) package of Ubuntu. It allocates half of the RAM as zram, and splits that up into one block device per CPU core to maximize performance. Once set up, you can monitor the zram usage using the `zramctl` command (no need to be `root` to run it). I've used it in my small Linux VM and on my Raspberry Pi, and it worked quite well. Just copy the commands from that package into an "activate.sh" and "deactive.sh", and run them as root.

Speaking of the Pi, there is an open-source script called [zram-config](https://github.com/ecdye/zram-config) (not to be confused with the Ubuntu package) that is far more flexible, using a configuration file to tune the amount of zram, the compression technique and so on. Designed for the Debian-based OS used by the Pi, it also offers using zram as an intermediate device before the `tmp` or some other file system, since the Pi's SD-card backed file system can be quite slow.

The impact on CPU should be minimal (I've read it uses less than 2% of a CPU core). Still, unless you frequently use the swap device on your Linux system, it may not be worthwhile to reserve a large amount of memory to a zram device.
