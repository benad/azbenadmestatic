---toml
date = "2018-06-29T11:42:16-04:00"
title = "Stretching to Debian 9"

---

The web page you’re currently reading is now hosted on a brand new Debian 9 server! The content is exactly the same as before, so you shouldn’t notice any difference.

So why did I update my server from Debian 7 to Debian 9? Well, [Debian 7 is now officially unsupported](https://www.debian.org/News/2018/20180601.en.html), which means it won’t get any security update. The suport ended on June 1st, though I actually actuvated the new Debian 9 servers a few days after. The [Long-Term Support for Debian 9](https://wiki.debian.org/LTS) will last for a few years, so I won’t have to upgrade Debian anytime soon. This month I had a few other things to finish on the server to complete the move, but nothing that would be noticed from web browsers.

For technical reasons, I couldn’t do an in-place upgrade, and in my case it would have been both too risky and an excuse to [move from 32-bit to 64-bit](https://benad.me/blog/2017/08/23/forever-64-bit/). For the most part, the configuration of Debian 9 is similar in design to Debian 7, with just a few changes here and there. The initial move to the new server was done doing a simple DNS change to point to its new IP addresses (IPv4 and IPv6), and I was able to fully test the new server, including its SSL certificate, by making local changes to my `/etc/hosts` file.

The most apparent difference came from doing a minimal install using the "net installer". Debian 9’s minimal install is *very* minimal, and smaller than what is considered "minimal" in other Linux distributions like CentOS. For example, `ifconfig` was missing, as in theory the built-in `ip` and `route` commands ought to be enough, though quite impractical. I installed the `net-tools` package to fix that.

Another annoying change was the way Debian 9 handled IPv6 routing, and I ended up doing something like this in `/etc/network/interfaces`:

```
iface ens3 inet6 manual
    up ifconfig ens3 add 2604:180:3:e16::384c/64
    up route -A inet6 add default dev ens3
    up /sbin/ip -6 route add default via 2604:180:3::1 dev ens3
    up route -A inet6 del default dev ens3
    down ifconfig ens3 del 2604:180:3:e16::384c/64
    down /sbin/ip -6 route del default via 2604:180:3::1 dev ens3
```

Yes, it’s strange. For some reason, the ip route commands refused to add a static route until I set up a dummy, broken default route with the `route` command, which has to be removed for the static route to work. Maybe there was a better way to do it (and I tried disabing IPv6 auto-configuration, with no success), but since I was doing all of this from the VM’s console and I didn’t want to reboot the VM anymore, I won’t fix this for the time being.
