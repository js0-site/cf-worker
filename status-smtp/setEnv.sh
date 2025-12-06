#!/usr/bin/env bash

set -e
DIR=$(realpath $0) && DIR=${DIR%/*}
set -a
. ../../conf/env/smtp.env
set +a
set -x

rm -f .dev.vars

setEnv() {
  echo "$1=\"$2\"" >>.dev.vars
  echo "$2" | wrangler secret put $1
}

setEnv R "$(bun -e 'import R from "../conf/status/REDIS.js"; console.log(`redis://${R.username}:${R.password}@${R.host}:${R.port}/${R.db}`)')"

setEnv SEND "$(bun -e 'import * as C from "../conf/status/SEND.js";console.log(JSON.stringify(C))')"
