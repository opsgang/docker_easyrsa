#!/bin/bash

set -o errexit
set -o pipefail

if [[ -d pki ]]; then
    rm -rf pki
fi

./easyrsa init-pki

cp -Rp pki /tmp/