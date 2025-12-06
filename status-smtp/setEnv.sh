#!/usr/bin/env bash

set -e
DIR=$(realpath $0) && DIR=${DIR%/*}
set -a
. ../../conf/env/smtp.env
. ../../conf/status/CLOUDFLARE_ACCOUNT_ID.env
set +a

rm -f .dev.vars

setEnv() {
  echo "$1=\"$2\"" >>.dev.vars
  echo "$2" | wrangler secret put $1
}

setEnv SMTP_USER $SMTP_USER
setEnv SMTP_PASSWORD $SMTP_PASSWORD
