---toml
date = "2023-03-04T13:59:08-05:00"
title = "The Static Web Site Server"

---

Hosting this web site on my own server (well, at least my own virtual machine) was a good learning experience, so for me a point of pride. I can at least say that I know how to host a Linux-based web server, buy a domain name, set up its TLS certificate, maintain the server with security updates, set up its backup plan, and so on. But even for a small-scale web site like this, it's still somewhat expensive (about $60 USD per year) and takes a lot of effort. Maybe that was fine in 2009, but do we expect small web sites to do the same in 2023? Is it still worth it to set up and maintain your own Linux server?

The need for static web site hosting didn't go away. Single Page Applications are quite common, or even just a handful of pages ("Few Pages Application"?). They avoid server-side rendering by generating the DOM from REST-like backends, with caching done on the client-side. So, yeah, a SPA is similar to this humble web site.

What then is the modern, recommended approach to hosting SPAs? I initially though that most of it could be hosted on Content Delivery Networks (CDNs), well, at least all the resources used by the web page. As long as the URL contains the "version" of the resource, where the page's resources are hosted doesn't matter much. But the base web page, as tiny as they can be with SPAs, still require a nice user-facing URL. And if you have multiple pages that users can navigate to independently, those would need to be updated in an atomic way, otherwise half the pages could resolved to an older version. This impacts this web site even more: The index pages of my [blog](/blog/) all need to be updated each time an article is added to the top, so navigation would be somewhat broken if half of those index pages pointed to the "wrong version".

Is there something like the old [Geocities](https://en.wikipedia.org/wiki/Yahoo!_GeoCities), but without all the ads, and where you can bring in your own domain name? Is it just as expensive as my cheap Linux VM server?

I recently got, as a job perk, a large amount of monthly credits I can use "for personal projects" on my own account on [Azure](https://azure.microsoft.com/). So, my original plan was to simply move my web site to a VM hosted in Azure. The cost would be slightly more expensive (Who knew static IPs aren't free anymore?), but would have been amply covered by my monthly credits.

Lucky for me though, they added a new service called [Azure Static Web Apps](https://azure.microsoft.com/en-ca/products/app-service/static/), and its lowest tier is free. Including bringing your own custom domain.

If you have a folder of static HTTP resources, place them on a GitHub repository (it could be private), install [Visual Studio Code](https://code.visualstudio.com/) and its [Azure Static Web Apps extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurestaticwebapps), and follow its steps. This will set up a "Resource Group", in it the static web app proper, and the [GitHub Action](https://docs.github.com/en/actions) to automatically deploy the files on every push. My first run at to took me about 10 minutes.

The GitHub Action set up for Static Web Apps supports many static web site generators, including [Hugo](https://gohugo.io/) that I use for the Blog section, but this is optional. My site also uses my own setup using [XML](https://en.wikipedia.org/wiki/XML) and [XSLT](https://en.wikipedia.org/wiki/XSLT) as a templating engine. I'm starting to dislike both XSLT and Hugo (and its limited use of the [Go templating engine](https://pkg.go.dev/text/template)), so if I end up using a new templating engine, I'll let the GitHub Action build the pages on each build. I'm looking into [11ty](https://www.11ty.dev/), and it looks promising. For now though, I'm generating the pages "offline", and pushing them into the GitHub to web site pipeline.

I was also surprised how easy and cheap (free) it was to use my own custom domain (benad.me and blog.benad.me) with Azure Static Web Apps. Some verification of ownership has to be done, either through some CNAME or TXT entry, but the process was painless. I don't have to maintain my own TLS server certificate with [Let's Encrypt](https://letsencrypt.org/) and [certbot](https://certbot.eff.org/), since Azure will sign the certificate for your custom domains, for free.

And you can now see the final result of this move. For an end user, this version of my web site if nearly identical to the previous one. But now I don't have to worry about security updates, backups, TLS certificate updates, and all that goes with exposing your own Linux machine to the internet. All for free (apart from the custom domain, of course).

To be very clear, I still know how to host my own Linux web server. If this "Static Web Apps" service breaks for some reason, I still have created a brand new Debian VM ready to be used just for this web site. But for the time being, this is good enough.