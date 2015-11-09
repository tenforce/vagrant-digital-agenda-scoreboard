#!/usr/bin/env bash
#################################################################
# Digital Agenda Score Board (build system requirements)

# yum -y --enablerepo rpmforge install dkms
yum -y groupinstall "Development Tools"
yum -y install gcc gcc-c++ gmake autoconf automake flex openssl git bzip2 make wget 
# yum -y install kernel-devel* kernel-headers*

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
yum -y install dos2unix firefox emacs autoconf vim curl gawk bison m4
yum -y install ntp ntpdate ntp-doc
chkconfig ntpd on

#################################################################
echo "****** Installing DAS software"
( pushd /vagrant
   # made sure all files in normal format (not windows)
   dos2unix scripts/*.in ;
   dos2unix config-files/* ;
   autoconf ; ./configure ;
   scripts/setup.sh ;
  popd )

#################################################################
# Setting up the browser
echo "****** Setting homepage of firefox"
echo "user_pref(\"browser.startup.homepage\", \"file:///vagrant/homepage.html\");" >> /usr/lib64/firefox/defaults/syspref.js
echo "user_pref(\"browser.startup.homepage\", \"file:///vagrant/homepage.html\");" >> /usr/lib64/firefox/defaults/preferences/all-redhat.js

#################################################################
# finishing and cleaning up.
echo "****** Bootstraping of Digital Agenda machine has been done"
echo "****** You will still have to update some permissions and start the services"
