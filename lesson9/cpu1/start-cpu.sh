#!/bin/bash

nice -n -19 ./script-cpu1.sh >> cpustat.log & nice -n 19 ./script-cpu2.sh >> cpustat.log
echo "____________________________________" >> cpustat.log
