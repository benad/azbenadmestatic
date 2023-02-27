#!/bin/bash

set -ex

pushd ../benadme-sources-git
rm -rf public
bash generate.sh
popd

pushd ../benadme-blog-git
rm -rf public
hugo
cp public/sitemap.xml public/blog/
popd

