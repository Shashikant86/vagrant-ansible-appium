# -*- mode: ruby -*-
# vi: set ft=ruby :
# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provision :shell, :path => 'bootstrap.sh'
  # config.vm.provision :ansible do |ansible|
  #   ansible.playbook = "playbook.yml"
  # end
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "appium-ansible"

  config.vm.provider "virtualbox" do |vb|
	  vb.customize ['modifyvm', :id, '--usb', 'on']
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant", "1"]
    vb.customize ['usbfilter', 'add', '0', '--target', :id, '--name', 'Galaxy Nexus', '--vendorid', '0x04e8']
  end
end
