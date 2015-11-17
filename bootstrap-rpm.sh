#!/usr/bin/env bash
#################################################################
# Digital Agenda Score Board (build system requirements)

if [ ! -f "/vagrant/jdk-6u43-linux-x64.bin" ]
then
    echo "**********************************************************"
    echo "**** jdk-6u43-linux-x64.bin needs to be downloaded   *****"
    echo "**** download it and run \"vagrant up --provision\"  *****"
    echo "**********************************************************"
    exit -1;
fi

#################################################################
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
echo "**************************************"
echo "****** Installing DAS software *******"
echo "**************************************"
( pushd /vagrant
   # made sure all files in normal format (not windows)
   dos2unix scripts/*.in ;
   dos2unix config-files/* ;
   autoconf ; ./configure ;
   if [ ! -f "jdk-6u43-linux-x64.bin" ]
   then
     echo "**********************************************************"
     echo "**** jdk-6u43-linux-x64.bin needs to be downloaded   *****"
     echo "**********************************************************"
     exit -1;
   fi
   
   if [ -f "server.crt" ]
   then
     scripts/setup.sh
     echo "**********************************************************************"
     echo "****** Bootstraping of DAD machine should have been done       *******"
     echo "****** You will still have to update the virtuoso permissions  *******"
     echo "****** and start the services                                  *******"
     echo "**********************************************************************"
   else
     echo "**********************************************(***********************"
     echo "****** SSL CERTIFICATE NOT FOUND - they need to be generated   *******"
     echo "****** and then script/setup run manually (see README)         *******"
     echo "**********************************************************************"     
   fi
  popd )

#################################################################
# Setting up the browser
echo "****** Setting homepage of firefox"
echo "user_pref(\"browser.startup.homepage\", \"file:///vagrant/homepage.html\");" >> /usr/lib64/firefox/defaults/syspref.js
echo "user_pref(\"browser.startup.homepage\", \"file:///vagrant/homepage.html\");" >> /usr/lib64/firefox/defaults/preferences/all-redhat.js

