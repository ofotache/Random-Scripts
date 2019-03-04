#!/bin/bash

clear
echo '_______________________'
echo 'Space usage'
echo
df -h / /var /home /boot | awk '{print $2,"\t", $3,"\t", $4,"\t",$5,"\t",$6'};
echo
echo
echo '_______________________'
echo 'Space usage for /var'
echo
du -sch .[!.]* /var/* | grep 'M\|G' |sort -h
echo
echo
echo '_______________________'
echo "Clean PackageKit Cache"
echo
pkcon refresh force
echo
echo
echo '_______________________'
echo 'Clean DNF DB Cache'
dnf clean dbcache
echo
echo
echo '_______________________'
echo 'Clean DNF Expired Cache'
dnf clean expire-cache
echo
echo
echo '_______________________'
echo 'Clean DNF Metadata'
dnf clean metadata
echo
echo
echo '_______________________'
echp 'Clean DNF Packages'
dnf clean packages
echo
echo
echo '_______________________'
echo 'Clean DNF All'
dnf clean all
echo
