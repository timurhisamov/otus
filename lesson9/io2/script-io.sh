#!/bin/bash

func1(){
SC1=`sudo ionice -c1 dd if=/dev/zero of=/HDD/dd_dir/first bs=100M count=10 2>&1 |tail -n 1 | awk '{print $8,$9}' | sed "s/s,/s/"`
echo "ionice -c1: $SC1" >> iostat.log  
}
func2(){
SC2=`sudo ionice -c3 dd if=/dev/zero of=/HDD/dd_dir/second bs=100M count=10 2>&1 |tail -n 1 | awk '{print $8,$9}' | sed "s/s,/s/"` 
echo "ionice -c3: $SC2" >> iostat.log
}

echo "-------------------" >> iostat.log
func1 & func2
