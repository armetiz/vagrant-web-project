# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

config_file = File.expand_path(File.join(File.dirname(__FILE__), 'vagrant/config.yml'))

local_config = {
    "network" => {
        "ip" => "10.1.1.42",
    },
    "provider" => {
        "memory" => "1024"
    }
}

if File.exist?(config_file)
    local_config.merge!(YAML.load_file(config_file))
end

Vagrant.configure("2") do |config|
  # Use major codename to allow consistent upgrade
  config.vm.box = "vagrantes-debian-wheezy-x64"
  config.vm.box_url = "https://dl.dropboxusercontent.com/u/197673519/debian-7.2.0.box"
  config.vm.network :private_network, ip: local_config['network']['ip']

  config.vm.synced_folder "project", "/vagrant", :nfs => false

  config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "vagrant/provisioning/puppet/manifests"
      puppet.manifest_file  = "vagrant.pp"
      puppet.module_path    = "vagrant/provisioning/puppet/modules"
  end

  config.vm.provider :virtualbox do |vb|
      # This two statements aim to speed up network (empiric)
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      vb.customize ["modifyvm", :id, "--memory", local_config['provider']['memory']]
  end
end
