---toml
date = "2018-12-02T20:48:22-05:00"
title = "Upgrading to HTTP/2"
permalink = "blog/2018/12/02/upgrading-to-http/2/"
---

A side effect of [upgrading my web server to Debian 9](https://benad.me/blog/2018/06/29/stretching-to-debian-9/) is that its version of [Apache HTTPD](https://httpd.apache.org/) now optionally supports [HTTP/2](https://en.wikipedia.org/wiki/HTTP/2). Not to be confused with the old "[Web 2.0](https://en.wikipedia.org/wiki/Web_2.0)" thing, this version 2 of the [Hypertext Transfer Protocol](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol) brings many optimizations for concurrent transfers within a single connection.

Enabling HTTP/2 on Debian 9 for this site was easy. I set up a file `/etc/apache2/conf-available/http2.conf` like this:

```
<IfModule http2_module>
    Protocols h2 h2c http/1.1
    H2Direct on
</IfModule>
```
And then I ran the following commands (each prefixed with sudo):
```
a2enconf http2
a2enmod http2
systemctl restart apache2
```
To help test it out I used Google Chrome with the [HTTP/2 and SPDY indicator](https://chrome.google.com/webstore/detail/http2-and-spdy-indicator/mpbpobfflnpcgagjijhmgnchggcjblin) and [chrome://net-internals/#events](chrome://net-internals/#events) to monitor the connections. Newer versions of [cURL](https://curl.haxx.se/) also support the "HTTP2" protocol, and fetching a page with the "verbose" option should show you the connection's upgrade to HTTP/2. If you try it out right now on this page, you should see a confirmation that this server indeed supports HTTP/2.

I normally run "HTTP application services" like Python or Java behind a reverse proxy and not directly accessible from the internet, and it can be argued that most HTTP REST-like services don't gain much from parallelism within a connection that HTTP/2 brings. Still, they are now starting to support HTTP/2, for example with [python-hyper](https://github.com/python-hyper/hyper-h2/blob/master/examples/twisted/twisted-server.py) and [Jetty](http://www.eclipse.org/jetty/documentation/current/http2.html). Here's a rather comprehensive [list of client and server HTTP/2 implementations](https://github.com/http2/http2-spec/wiki/Implementations).

We're still a few years before "HTTP/3" or [QUIC](https://tools.ietf.org/html/draft-ietf-quic-http-16) gains much use outside of Google's own services, but for now enabling HTTP/2 is so simple it should almost be considered a default. The only thing that could complicate its deployment is that most HTTP/2 clients require TLS, but then if you're still not using TLS you have bigger issues.
