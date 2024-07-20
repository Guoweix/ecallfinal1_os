#!/bin/bash

sudo umount Test

sudo losetup -d /dev/loop0

sudo losetup /dev/loop0 Img/sdcard.img

sudo mount /dev/loop0 Test