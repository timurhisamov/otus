#!/bin/bash

func1(){
SC1=`nice -n -19 dd if=/dev/zero of=/dev/null bs=100M count=1000 2>/tmp/sc1.$$ | md5sum`
P1=`cat /tmp/sc1.$$ |tail -n 1 | awk '{print $8,$9}' | sed "s/s,/s/"`
echo "nice -n -19: $P1" >> cpustat.log
}

func2(){
SC2=`nice -n 19 dd if=/dev/zero of=/dev/null bs=100M count=1000 2>/tmp/sc2.$$ | md5sum`
P2=`cat /tmp/sc2.$$ |tail -n 1 | awk '{print $8,$9}' | sed "s/s,/s/"`
echo "nice -n 19: $P2" >> cpustat.log
}


func1 & func2
echo "____________________________________" >> cpustat.log
rm /tmp/sc1.$$
rm /tmp/sc2.$$
