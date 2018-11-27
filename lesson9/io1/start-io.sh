#!/bin/bash

echo "____________________________________" >> iostat.log
sudo ionice -c1 ./script-io1.sh >> iostat.log & sudo ionice -c3 ./script-io2.sh >> iostat.log
