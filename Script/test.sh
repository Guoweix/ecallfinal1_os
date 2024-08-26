#!/bin/bash
sudo minicom -D /dev/ttyUSB0 -b 115200
sleep 2
send "ls"
