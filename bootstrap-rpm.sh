#!/usr/bin/env bash
#################################################################
# Digital Agenda Score Board (build system requirements)

#################################################################
# Sort out basic + docker installation for centos 7
# yum -y install epel-release-7
yum -y update

yum -y groupinstall "Desktop" "Desktop Platform" "X Window System" "Fonts"
yum -y groupinstall "Graphical Administration Tools"
yum -y groupinstall "Internet Browser"
yum -y groupinstall "General Purpose Desktop"
yum -y groupinstall "Office Suite and Productivity"
yum -y groupinstall "Graphics Creation Tools"

# Check boot init (change to graphical)
sed -i -e 's/:3:/:5:/g' /etc/inittab

# Install decent editor and some other obvious bits
yum --enablerepo rpmforge install dkms
yum -y install kernel-devel kernel-headers
yum -y install kernel-devel-`uname -r` kernel-headers-`uname -r`
yum -y install dos2unix firefox emacs
yum -y install emacs autoconf

#################################################################
# finishing and cleaning up.
echo "****** done with bootstrap of Digital Agenda Test machine"
