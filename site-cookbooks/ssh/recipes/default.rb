user 'deploy' do
  supports :manage_home => true
  home '/home/deploy'
  shell '/bin/bash'
end

directory '/home/deploy/.ssh/' do
  owner 'deploy'
  group 'deploy'
  mode '0700'
  action :create
  recursive true
end

template '/home/deploy/.ssh/authorized_keys' do
  source 'authorized_keys.erb'
  owner 'deploy'
  group 'deploy'
  mode '0600'

  variables(
    :keys => data_bag_item('ssh', 'authorized_keys')['keys']
  )
end
