#!/bin/bash

SC1=`dd if=/dev/zero of=/HDD/dd_dir/first bs=100M count=10 2>&1 |tail -n 1 | awk '{print $8,$9}' | sed "s/,//"`
echo "ionice -c1: $SC1"  
