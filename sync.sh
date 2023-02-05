#!/bin/bash

set -ex

DIR=$( dirname $( realpath "$0" ) )

cd "$DIR"

rm -rf public
mkdir public

rsync -avc ../benadme-generated-git/ ./public --exclude '.hg*' --exclude '*.sh' --exclude 'lftp*' --cvs-exclude --exclude 'archives/lastpass' --exclude 'blog' \
--exclude feeds --exclude '*.xml'

mkdir -p public/blog/
rsync -avc ../benadme-blog-git/public/blog/ public/blog/
