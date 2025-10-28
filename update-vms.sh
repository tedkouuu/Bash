#!/usr/bin/env bash

for h in 192.168.2.101 192.168.2.116 192.168.2.201; do
  echo "===== $h ====="
  sshpass -p '1234' ssh -o StrictHostKeyChecking=no teo@"$h" '
    sudo -n apt-get update
    sudo -n apt-get -y full-upgrade
    sudo -n apt-get -y autoremove
    uname -r
  '
done

echo "Done."