#!/bin/sh

command_test=`rpm -qa | grep mysql`
for line in $command_test; do
    echo "yum remove -y $line"
    yum remove -y $line
done
echo "-------------"