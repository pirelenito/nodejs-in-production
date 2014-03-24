# knife tool is already installed at the destination box with chef
# this just installs the aditional knife-solo gem to allow provisioning
# remote boxes from withing the Vagrant box

chef_gem 'knife-solo'
