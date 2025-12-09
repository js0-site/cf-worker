#!/usr/bin/env bash

set -e
DIR=$(realpath $0) && DIR=${DIR%/*}
. $DIR/.sh/project
set -x

rm -rf .wrangler/tmp
cd src
oxfmt
oxlint
bun run deploy
