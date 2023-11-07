---toml
date = "2016-09-12T21:15:00-04:00"
title = "HTTPS, the New Standard"

---

The "web" used to be simple. A simple plain-text protocol ([HTTP](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol)) and a simple plain-text markup format ([HTML](https://en.wikipedia.org/wiki/HTML)). Sadly, after 20 years, things are not as simple anymore.

Nowadays, it is commonplace for ISPs to inject either "customer communications" or downright advertisement into unencrypted HTTP communications. Using web sites from an unencrypted or "open" WiFi is often a vector for a malicious user to [inject viruses into any web page](https://en.wikipedia.org/wiki/Iframe_virus), let alone steal passwords and login tokens from popular web sites. On a larger scale, governments now have the capability to do [deep packet inspection](https://en.wikipedia.org/wiki/Deep_packet_inspection) to systematically either [censor](https://citizenlab.org/2013/06/o-pakistan/) or keep a record of all web traffic.

So, indirectly, my simple, unencrypted web site can become dangerous.

Buying an [SSL](https://en.wikipedia.org/wiki/Transport_Layer_Security) certificate (actually TLS) used to be something both expensive and difficult to set up. Now with the help of "[Let's Encrypt](https://letsencrypt.org/)", any web site can be set up to use HTTPS, for free. Sure, the certificate merely says that HTTPS traffic came from the real web site, but that's good enough. And for a personal web site, there is limited value in buying one of those expensive "[Extended Validation](https://en.wikipedia.org/wiki/Extended_Validation_Certificate)" certificates.

This is why my web site is now using HTTPS. In fact, HTTPS only, though by doing so I've had to cut off browsers like [Internet Explorer 6](https://en.wikipedia.org/wiki/Internet_Explorer_version_history#Microsoft_Internet_Explorer_6), since they do not support secure cryptographic algorithms anymore. It breaks my rule of [graceful degradation](https://benad.me/meta_future.html), but ultimately the security of people that visit my web site is more important than supporting their 15-year old web browser.

What is sad with this though is that as older cryptographic algorithms become obsolete, so too are machines too old to support the new algorithms, let alone those "[Internet appliances](https://en.wikipedia.org/wiki/Internet_appliance)" that aren't supported anymore. This means that, unlike the original idea of simple, plain-text protocols, web browsers have to be at most a decade old to be usable.

And still, HTTP with TLS 1.2 is merely "good enough". There are simply too many root certificates installed in our systems, with many from states that could hijack secure connections to popular site by maliciously create their own certificates for them. [HTTP/2](https://en.wikipedia.org/wiki/HTTP/2) is a nice update, but pales to modern techniques used in [QUIC](https://tools.ietf.org/html/draft-hamilton-early-deployment-quic-00). Considering that even today only a fraction of the Internet is using [IPv6](https://en.wikipedia.org/wiki/IPv6), it may take another decade before QUIC becomes commonplace, let alone HTTP/2.

For now, enjoy the green lock displayed on my web site!

*Implementation Notes*

The site [Cipherli.st](https://cipherli.st/) is an excellent starting point to configure your web server for maximum security. I also used the [Qualys SSL Labs](https://www.ssllabs.com/ssltest/) SSL test service to verify that my server has the highest security grade (A+). 

I was also tempted to move from Apache to [Caddy](https://en.wikipedia.org/wiki/Caddy_%28web_server%29), as Caddy supports HTTP/2, QUIC and even Hugo (what [I use for the blog section of this site](https://benad.me/meta_blog.html)), but then I remembered that I specifically chose [Apache](https://httpd.apache.org/) on [Debian](https://www.debian.org/) for its long-term, worry-free security updates, compared to a bleeding edge web server.