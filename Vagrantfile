# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = "box-cutter/centos65-desktop"

  # Attempt to cache downloaded files (only if plugin is present).
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
    config.cache.enable :yum
    config.cache.enable :gem
  end

  config.vm.provision :shell, path: "bootstrap-rpm.sh"
  # config.vm.synced_folder "OpenData", "/vagrant_opendata"
  config.vm.synced_folder ".", "/vagrant"
  config.ssh.insert_key = false
  config.vm.boot_timeout = 500
  
  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  config.vm.provider "virtualbox" do |vb|
      vb.name = "VagrantDigitalAgendaScoreboard"
      vb.gui = true
      vb.customize ["modifyvm", :id, "--memory", 6000]
      vb.customize ["modifyvm", :id, "--vram", 64]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
      vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
  end
end
