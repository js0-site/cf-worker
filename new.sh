#!/usr/bin/env bash

set -e
if [ -z "$1" ]; then
  echo "$0 <PROJECT>"
  exit 1
fi

PROJECT=$1
DIR=$(realpath $0) && DIR=${DIR%/*}
cd $DIR
set -x

mkdir -p $PROJECT

cd $PROJECT
if [ ! -f "wrangler.toml" ]; then
  cat >wrangler.toml <<EOF
name = "$PROJECT"
main = "src/index.js"
compatibility_date = "$(date +%Y-%m-%d)"
compatibility_flags = ["nodejs_compat"]

[observability]
enabled = true

[triggers]
crons = ["* * * * *"]

[limits]
cpu_ms = 300000
EOF
fi

if [ ! -f "package.json" ]; then
  cat >package.json <<EOF
{
  "name": "$PROJECT",
  "version": "0.1.0",
  "type":"module",
  "scripts": {
    "deploy": "wrangler deploy",
    "dev": "wrangler dev --test-scheduled",
    "start": "wrangler dev --test-scheduled"
  }
}
EOF
  bun i -D wrangler
fi

mkdir -p src
cd src
if [ ! -f "index.js" ]; then
  cat >index.js <<EOF
export default {
  async fetch(req) {
    const url = new URL(req.url);
    url.pathname = "/__scheduled";
    url.searchParams.append("cron", "* * * * *");
    return new Response("");
  },

  async scheduled(_event, env, _ctx) {
    console.log("scheduled");
  }
};
EOF
fi
