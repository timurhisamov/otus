#!/bin/bash

SC2=`dd if=/dev/zero of=/HDD/dd_dir/second bs=100M count=10 2>&1 |tail -n 1 | awk '{print $8,$9}' | sed "s/,//"` 
echo "ionice -c3: $SC2"
