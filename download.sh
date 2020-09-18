#!/usr/bin/env bash

host="http://oldpc";
#host="https://mrcyjanek.net"
echo "Don't use it"
exit 1;
rm -rf prebuild/
for cpuarch in armhf arm64 amd64;
do
    mkdir -p "prebuild/${cpuarch}/"
    wget "$host/ci/job/bitcoin-${cpuarch}/ws/src/bitcoind" -O "prebuild/${cpuarch}/bitcoind"
    chmod +x "prebuild/${cpuarch}/bitcoind"
done;
