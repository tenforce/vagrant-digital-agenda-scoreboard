#!/usr/bin/env bash
#################################################################
# Digital Agenda Score Board (build system requirements)

#################################################################
# Sort out basic + docker installation for centos 7
# yum -y install epel-release-7
yum -y groupinstall "Desktop" "Desktop Platform" "X Window System" "Fonts"
yum -y groupinstall "Graphical Administration Tools"
yum -y groupinstall "Internet Browser"
yum -y groupinstall "General Purpose Desktop"
yum -y groupinstall "Office Suite and Productivity"
# yum -y groupinstall "Graphics Creation Tools"

# Check boot init (change to graphical)
sed -i -e 's/:3:/:5:/g' /etc/inittab

# Install decent editor and some other obvious bits
yum --enablerepo rpmforge install dkms
yum -y install kernel-devel kernel-headers
yum -y install kernel-devel-`uname -r` kernel-headers-`uname -r`
yum -y install dos2unix firefox emacs
yum -y install emacs autoconf vim make wget curl gawk bison m4
yum -y install gcc gmake autoconf automake flex openssl git
yum -y install ntp ntpdate ntp-doc
chkconfig ntpd on

#################################################################
echo "****** Installing DAS software"
( pushd /vagrant
   # made sure all files in normal format (not windows)
   dos2unix scripts/*.in ;
   dos2unix config-files/* ;
   autoconf ; ./configure ; scripts/setup.sh
  popd )

#################################################################
# finishing and cleaning up.
echo "****** Bootstraping of Digital Agenda machine has been done"
echo "****** You will still have to update some permissions and start the services"
