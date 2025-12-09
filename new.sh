#!/usr/bin/env bash

set -e
if [ -z "$1" ]; then
  echo "$0 <PROJECT>"
  exit 1
fi

PROJECT=$1
DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
if [ -d "$PROJECT" ]; then
  echo "$PROJECT EXIST"
  exit
fi
set -x

cp -R _tmpl $PROJECT

cd $PROJECT

sed -i '' "1i\\
compatibility_date = $(date +%Y-%m-%d)
" wrangler.toml

fd --type file --hidden --exclude .git -x sd _tmpl $PROJECT "{}"
git add .
