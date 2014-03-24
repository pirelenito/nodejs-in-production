# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.omnibus.chef_version = '11.10.4'

  config.vm.box = 'chef/ubuntu-12.04'

  config.vm.provision :chef_solo do |chef|
    chef.data_bags_path = 'data_bags'
    chef.cookbooks_path = 'site-cookbooks'
    chef.roles_path = 'roles'

    chef.add_role 'vagrant'

    # run the 'production' cookbooks inside the Vagrant box
    # chef.add_role 'application'
  end

  config.vm.network :forwarded_port, guest: 3000, host: 3000 # Node application
  config.vm.network :forwarded_port, guest: 5678, host: 5678  # HTTP mongodb admin
end
