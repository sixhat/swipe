#!/usr/bin/env bash
# Code inspired and adapted from the code of twic-db-aggregator
# http://code.google.com/p/twic-db-aggregator/
# License GPL v2 http://www.gnu.org/licenses/old-licenses/gpl-2.0.html

set -xe

I=$1
F=$2
while (( I < F )); do
  wget https://www.theweekinchess.com/zips/twic"${I}"g.zip && unzip twic"${I}"g.zip && cat twic"${I}".pgn >> big.pgn
  I=$((I + 1))
done

rm -rf twic*
