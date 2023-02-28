# Notes

## Requirements

* BASH
* Perl
* curl (for `mvnw`)
* Java 11
* [Hugo 0.15](https://github.com/gohugoio/hugo/releases/tag/v0.15)

## Setup

```sh
git clone -b cleanup git@github.com:benad/benadme-sources-git.git
git clone -b azstatic git@github.com:benad/benadme-blog-git.git
git clone git@github.com:benad/azbenadmestatic.git
```

As a separate project, that handles redirection from `blog.benad.me` to
`benad.me`: https://github.com/benad/azbenadmestaticblog .

## Usage

```sh
bash build.sh
bash sync.sh
git commit -m "Updates..."
git push
```
