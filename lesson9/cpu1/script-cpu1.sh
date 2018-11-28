#!/bin/bash

SC1=`dd if=/dev/zero of=/dev/null bs=100M count=1000 2>/tmp/sc1.$$ | md5sum`
P1=`cat /tmp/sc1.$$ |tail -n 1 | awk '{print $8,$9}' | sed "s/,//"`

echo "nice -n -19: $P1"
rm /tmp/sc1.$$
