---toml
date = "2019-05-20T14:59:56-04:00"
title = "Browsing Home"

---

When I want to access some of my home servers aways from home, I typically use an SSH connection rather than exposing
multiple ports through my router. Most of my "home services" run as HTTP web servers, so I would use
SSH port forwarding to access that server's IP and port on my internal network. As the numbers of those
servers grew, maitaining a large list of port forwards, and remembering which local port connects to what
remote IP and port was too difficult to manage. I didn't want to go down the route of setting up a personal VPN
service, so was there something I do with SSH?

It just so happens that one of the port forwarding options supported by [OpenSSH](https://www.openssh.com/)
(and other SSH clients like [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/)) is the dynamic
port forwarding, with the `-D` option. This makes
SSH run a [SOCKS](https://en.wikipedia.org/wiki/SOCKS) proxy that can be used to forward any network
request, with no need to reserve a local port for each remote IP and port you want to access.

SOCKS is supported on most OS, though it is typically a system-wide setting. In my case, I'd rather
set up a web browser to use my proxy only when I want it to, leaving the rest of my system's network
intact. Also, the web browser can forward DNS requests through the proxy, which is useful if like me
you have a custom DNS server at home.

Firefox has settings to make it use a SOCKS proxy, but you can also use the
[proxy-toggle](https://addons.mozilla.org/en-US/firefox/addon/proxy-toggle/) extension to quickly
turn on or off its use of your proxy. On Google Chrome, you can also use the more sophisticated
extension [Proxy SwitchyOmega](https://chrome.google.com/webstore/detail/proxy-switchyomega/padekgcemlokbadohgkifijomclgjgif),
which also supports using the proxy only for certain domain names or IPs that would match yours
on your home network.

On iOS, things are a bit more complicated.
The [Termius](https://www.termius.com/) SSH client
that I use on iOS supports dynamic proxies.
For the SOCKS settings, you could build your own [PAC](https://en.wikipedia.org/wiki/Proxy_auto-config)
file and expose it as a public HTTPS URL, but again this would also be system-wide and difficult to turn on and off
whenever you open the SSH connection. My solution then is to use the venerable
[iCab web broswer](https://itunes.apple.com/ca/app/icab-mobile-web-browser/id308111628?l=fr&mt=8), which not only supports
SOCKS settings on its own that you can easily turn on and off, but also creating multiple profiles, each with its own proxy settings.
