# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "ubuntu-11.10"
  config.vm.box_url = "https://github.com/downloads/KristianOellegaard/vagrant-base-boxes/ubuntu-11.10-64bit.box"
  config.vm.provision :puppet do |puppet|
   puppet.manifests_path = "./"
   puppet.manifest_file  = "vagrant.pp"
   puppet.module_path = "../"
  end
end
