#!/usr/bin/env bash

set -ex
DIR=$(realpath $0) && DIR=${DIR%/*}
. $DIR/.sh/project

if ! command -v watchexec 2>/dev/null; then
  cargo install watchexec-cli
fi

$DIR/.sh/cronTest.sh
