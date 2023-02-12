#!/bin/bash

set -ex

DIR=$( dirname $( realpath "$0" ) )

cd "$DIR"

rm -rf public
mkdir public

cp -rv -t public ../benadme-sources-git/public/*

mkdir -p public/blog/
cp -rv -t public ../benadme-blog-git/public/blog

python gen_config.py > public/staticwebapp.config.json