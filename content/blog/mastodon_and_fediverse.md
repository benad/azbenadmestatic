---toml
date = "2023-01-22T15:47:00-05:00"
title = "Mastodon and the Fediverse"

---

As you may have noticed on my ["About" page](https://benad.me/links.html), I moved away from Twitter to a Mastodon server (my user is `@benad@mstdn.party`). This was mostly due to the now uncertain future on Twitter, but also because Twitter is now simply unpleasant to use. Mastodon felt close enough to Twitter to be a good choice.

As soon as you sign up to Mastodon, you'll notice that it's quite different than other centralized and commercial "Web 2.0" social networks: You have to pick your server. This is similar to when you sign up to an email host: You pick the host, then your user name. Like email, each server has different ownership and rules. Not all servers are open to the public for registering new accounts.

Once you have your account, Mastodon feels similar to Usenet, in the sense that you can see and interact with users of other Mastodon servers ("instances") through your own server.

This decentralized approach raised concerns that the Mastodon protocol or service wouldn't scale well. But those problems are far from new. With email, while spam still exists, it is manageable. As for the public content itself, ranging from illegal content to trollish behavior, each server has their own enforced content moderation policies. It is possible for a Mastodon server to refuse to interact with another server (by pulling its content) if their content policies are too incompatible. While this could create isolated clusters, nothing prevents a user from having one account on each of such "clusters", as long as the user follows the policies on each.

Mastodon is also compatible with the [ActivityPub](https://www.w3.org/TR/activitypub/) protocol from [W3C](https://www.w3.org/). This makes it possible for Mastodon to interact with "activity feeds" of other services (often decentralized too). This decentralized "federation" of services was termed the [Fediverse](https://en.wikipedia.org/wiki/Fediverse).

For example, [PeerTube](https://joinpeertube.org/) is an open-source server that lets you host a video publish site, similar to YouTube. Since it supports ActivityPub, a Mastodon user can subscribe to the activity of any PeerTube account. If you wanted, let's say, to subscribe to [Blender](https://www.blender.org/)'s video channel, user `blender` on PeerTube site `video.blender.org`, you can use your Mastodon client to subscribe to the user `@blender@video.blender.org`, and then you'll see their video on your Mastodon feed.

This makes Mastodon far more resilient than a centralized, commercial social network. Like email, a company can self-host their own Mastodon server, or make use of a hosting service, and only let their employees have accounts on it. For social networks (or even blogs) that already exist, they can also implement ActivityPub and be part of the Fediverse.

So, even if Mastodon remains "niche", a bit like what became of Usenet (and even email itself), it is unlikely to vanish or break at the whims of the next CEO of the company that owns the entire thing.