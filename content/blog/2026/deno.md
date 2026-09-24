---
date: "2026-09-26T14:00:00-04:00"
title: "Securing 11ty with Deno"
---

As I'm using 11ty to generate this web site, I was constantly annoyed with the way NPM works for NodeJS. While there are frequent security updates (for things that won't impact much a static site generator), they are easily installed using `npm audit fix`, and GitHub's own "dependabot" does a decent job in alerting me about those security issues. I recently tried to reduce the number of dependencies I use for this site beyond the bare minimum needed for 11ty, and for those I prefer always NPM modules that don't bring much (if any) additional transitive dependencies.

Even then, each time I try out a new NPM module, I feel I'm gambling with security. NPM modules have pre and post install scripts, so merely adding them to `package.json` is a security risk. Typosquatting is a real thing. This remind me of how Perl's CPAN module or Python's "pip" can compile and execute native binaries as part of their normal installation process of installing additional modules, but then for both Linux distribution would often lock on a specific version of the scripting engine and offer in their package managers precompiles and security reviewed versions of popular modules.

But that still doesn't solve the issue that, when 11ty's builder runs in the GitHub Action pipeline, it has full access to the security token used to upload the generated site to the Azure host. A malicious NPM module could extract those tokens and send them over the network.

I've recently looked into Deno, an alternative to NodeJS, and it seems to be better aligned with my security concerns. When installing modules, it doesn't run any kind of installation script offered by the packages. When running a JavaScript module, it locks down by default any access to the host environment, including shell scripting, launching processes, environment variables, networks access, and so on.

At first, I just tried to see if 11ty (both the current version 3 and the upcoming version 4), and it worked! A few adjustments were needed for my setup, but those remained backwards compatible with NodeJS, so I could still revert things. Once I made it work, I locked down its permissions to a bare minimum, adjusting my script until it works.