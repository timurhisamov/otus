#!/bin/bash

SC2=`dd if=/dev/zero of=/dev/null bs=100M count=1000 2>/tmp/sc2.$$ | md5sum` 

P2=`cat /tmp/sc2.$$ |tail -n 1 | awk '{print $8,$9}' | sed "s/,//"`
echo "nice -n 19: $P2"

rm /tmp/sc2.$$
