#!/bin/bash
ll_d="2018-11-08"

# Замена месяца
ll_dd=`echo $ll_d |{
sed -e 's/-01-/\/Jan\//'|
sed -e 's/-02-/\/Feb\//'|
sed -e 's/-03-/\/Mar\//'|
sed -e 's/-04-/\/Apr\//'|
sed -e 's/-05-/\/May\//'|
sed -e 's/-06-/\/Jun\//'|
sed -e 's/-07-/\/Jul\//'|
sed -e 's/-08-/\/Aug\//'|
sed -e 's/-09-/\/Sep\//'|
sed -e 's/-10-/\/Oct\//'|
sed -e 's/-11-/\/Nov\//'|
sed -e 's/-12-/\/Dec\//'
}`
echo $ll_dd

# Форматирование в вид 12/Nov/2018
ll_dd1=`echo $ll_dd | awk -F "-"  '{print $3,$2,$1}' `
echo $ll_dd1

