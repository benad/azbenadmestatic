---toml
date = "2019-02-10T15:42:47-05:00"
title = "Monorepos and Semantic Versioning"

---

I accidentally came across what is called [Monorepos](https://en.m.wikipedia.org/wiki/Monorepo), short for "monolitic repositories", when I followed the progress of [Foursquare](https://en.wikipedia.org/wiki/Foursquare_City_Guide)'s [Twofishes project](https://github.com/foursquare/twofishes), and the odd practices of the [Go](https://en.wikipedia.org/wiki/Go_%28programming_language%29) development model.

Monorepos aren't a new thing. *Way back then*, it wasn't unusual to place all the code in a shared folder on a network, and back that up using date-labeled folders from time to time. For that to have some kind of resurgence, let alone with such a *cool* name, seems unusual.

While I won't repeat the obvious advantages of using such a approach compared to using one repository per project or module, there are subtle yet dangerous disadvantages in using monorepos.

The biggest one is how it breaks any kind of implicit support contract you could have with versioned modules. With a monorepo, a new project can simply start by branching the common codebase, but then pulling latest changes from the main branch can be quite risky. When using [Semantic Versioning](https://semver.org/) to describe the API of a module, it makes it clear when changes can break backwards compatibility. With monorepos, the version is simply a "point in time" of the main branch, and anything can break after that. It places the onus of keeping a project's branch up-to-date with main branch on each project, and it isn't clear where the responsibilities lies in merging back each project's useful code back to the main branch.

In fact, being able to integrate with another's module at the level of its source code almost begs for some new definition of a semantic version: Rather than describing the version from the point of view of a module's external interface, it would be from its code's design. For example, if I were to rename an internal class' name, with a classical definition of semantic versioning that could be at worst a 0.0.1 version delta, but with monorepos, any project branch could link to that specific class name, so that would imply a breaking change worthy of a 1.0.0 delta.

As a side effect, monorepos would discourage any kind of major code redesign, since that would break any kind of source-code-level per-project integration. For example, project branches could avoid pulling changes from the main branch if its design changed too much, so you would have to apply security patches to multiple branches at once, even if those branches do essentially the same thing from a modular, semantic versioning point of view.

Another significant disadvantage is that monorepos promotes (or could even enforce) the use of a single programming language, or worse, some kind of software design *monoculture*. This may be useful for small corporations and groups, but could significantly impede software design innovation, or make introducing additional programming languages to the codebase too difficult to even try.

I'm trying my very best to not draw analogies to [Tron](https://en.wikipedia.org/wiki/Tron), but the fact that we're still even considering monorepos as a good thing nearly 40 years later is saddening.
