#!/usr/bin/env bash

case $(id -u) in
    0)
		sudo apt-get update
    apt-get install -y python-software-properties python g++ make
    sudo add-apt-repository ppa:chris-lea/node.js -y
		sudo apt-get update -y
		sudo apt-get install nodejs -y
		sudo apt-get update -y
		sudo apt-get install nodejs -y
		sudo apt-get install curl -y
		sudo apt-get install git -y
		sudo apt-get install unzip -y
		sudo apt-get install openjdk-6-jre -y
    sudo apt-get install -y bash curl git patch bzip2 build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev libgdbm-dev ncurses-dev automake libtool bison subversion pkg-config libffi-dev libcurl3-dev imagemagick libmagickwand-dev libpcre3-dev
    sudo apt-get install android-tools-adb -y
    sudo -u vagrant -i $0
		;;
	*)

     ##################################################################################################
      # Directory
     ##################################################################################################
     sudo mkdir /opt/adt/
     sudo mkdir /opt/appium/
     sudo mkdir /opt/devicehive/
     sudo mkdir /opt/devicehive/logs/
     sudo mkdir  /opt/devicehive/pids/


		##################################################################################################
		# Node
		##################################################################################################

		# Enable npm to be used without sudo

		# Add ~/npm/bin to the PATH variable
		echo "export PATH=$HOME/npm/bin:$PATH" >> ~/.bashrc

		# Execute the .bashrc file
		. ~/.bashrc

		##################################################################################################
		# ADT
		##################################################################################################

		# Download Android SDK

    curl -O http://dl.google.com/android/android-sdk_r24.1.2-linux.tgz

		# Extract
    tar -xvf android-sdk_r24.1.2-linux.tgz
    sudo mv /home/vagrant/android-sdk-linux/ /opt/adt/
		# Define new ANDROID_HOME env var inside .bashrc
		echo 'export ANDROID_HOME="/opt/adt/android-sdk-linux"' >> ~/.bashrc

		# Add ~/npm/bin to the PATH variable
		echo "export PATH=$ANDROID_HOME/platform-tools:$PATH" >> ~/.bashrc
		echo "export PATH=$ANDROID_HOME/tools:$PATH" >> ~/.bashrc

		# Execute the .bashrc file
		. ~/.bashrc

		#./android update sdk -u
		( sleep 5 && while [ 1 ]; do sleep 1; echo y; done ) | /opt/adt/android-sdk-linux/tools/android update sdk -u --filter android-17,android-18,android-19

		##################################################################################################
		# RVM
		##################################################################################################

    cd /home/vagrant
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    \curl -L https://get.rvm.io | bash -s stable

    source /home/vagrant/.profile
    source /home/vagrant/.rvm/scripts/rvm

    sed -ie 's/ftp\.ruby-lang\.org\/pub/ruby\.taobao\.org\/mirrors/' /home/vagrant/.rvm/config/db
    rvm install 1.9.3
    rvm use 1.9.3 --default

    gem source -r http://rubygems.org/
    gem install bundler

    source /home/vagrant/.bashrc
    source /home/vagrant/.bash_profile
    source /home/vagrant/.profile
		##################################################################################################
		# Enable USB devices
		##################################################################################################

		# Add New Devices to the 51.android rules
		sudo cp /vagrant/android.rules /etc/udev/rules.d/51-android.rules
		sudo chmod 644   /etc/udev/rules.d/51-android.rules
		sudo chown root. /etc/udev/rules.d/51-android.rules
		sudo service udev restart
		sudo killall adb

		##################################################################################################
		# Appium
		##################################################################################################

		# Install Appium
    npm install appium
    sudo mv /home/vagrant/node_modules/ /opt/appium/

		##################################################################################################
		# Launching VM
		##################################################################################################

		echo "################################################################"
		echo "Bootstrap finished:"
		echo " > Please run 'vagrant ssh' to launch VM"
		echo "################################################################"

		##################################################################################################
		# Connecting USB devices
		##################################################################################################

		echo "USB Device setup:"
		echo " > Please connect your device via USB"
		echo " > \$ANDROID_HOME/platform-tools/adb devices"
		echo "################################################################"

		##################################################################################################
		# Next steps...
		##################################################################################################

		echo "Run Appium Server Manually"
		echo " > cd /opt/appium"
		echo " > ./node_modules/.bin/appium"

		;;
esac
