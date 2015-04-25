# Appium development ENV Installtion with Vagrant and Ansible

Vagrant-ansible-hive will install BBC Hive CI to vagrant boxes provisioned with ansible and shell.

## Requirement

* You need to have vagrant installed
* You need to have ansible installed

          $ brew install ansible

* Optional: Create Shared direcory on your Mac/PC that you want to use on vagrant Box and update Vagrantfile accordingly. Checkout source code in the shared directory.

## Usage

Once you ready clone the repo

      $ cd vagrant-ansible-appium
      $ vagrant up

This will install Ubuntu box with all neccessery libraries including

* All apt packages
* Ruby with RVM
* Android ADT bundle
* NodeJS and Appium
* Allows USB to connect to Vagrant Box

Now SSH into vagrant machine

       $ vagrant ssh

Now we will have logged into fully provisioned vagrant box. You can launch appium

         vagrant@appium-ansible:~$ nodejs node_modules/appium/bin/appium.js
