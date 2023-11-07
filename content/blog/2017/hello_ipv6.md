---toml
date = "2017-10-12T19:04:24-04:00"
title = "Hello, IPv6!"

---

A quick post to mention that this site should be available on [IPv6](https://en.wikipedia.org/wiki/IPv6).
Its IP address is `2604:180::e8e3:93ef` and it has an `AAAA` record for `benad.me`.
My old [Apple AirPort Extreme](https://en.wikipedia.org/wiki/AirPort_Extreme#5th_generation)
can only use Tunnel IPv6 mode with [PPPoE](https://en.wikipedia.org/wiki/Point-to-point_protocol_over_Ethernet),
but still the following curl command worked: `curl -s6 "https://benad.me/" --verbose > /dev/null`.
You can also enter `https://[2604:180::e8e3:93ef]/` in your web browser, if you ignore the certificate
warnings.

