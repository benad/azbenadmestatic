---toml
date = "2026-03-06T14:20:00-05:00"
title = "Oat and AI"
---

You might now notice that this web site looks a little bit different, with the most glaring change is its support for "dark mode". Well, that's because I switch its CSS and UI framework from [Bootstrap](https://getbootstrap.com/) to [Oat](https://oat.ink/). It makes a non-cached download of a page, with all its dependencies, from about 75 kB to 15 kB. It is also far more up-to-date to newer standards, which I took as an occasion to remove older support for Internet Explorer and so on.

In the past, this kind of change would have taken me a weekend of effort, if not more. Most of it would be because I strongly dislike CSS development. Instead, I "[vibe coded](https://en.wikipedia.org/wiki/Vibe_coding)" it with the assistance of [GitHub Copilot CLI](https://github.com/features/copilot/cli/). If you look at [this site's Git commit history](https://github.com/benad/azbenadmestatic/commits/main/), the initial version took me about 30 minutes to produce. I made some adjustments to the changes Copilot generated, but even then I was able to use screenshots of the older version of this site to clearly describe what I wanted.
