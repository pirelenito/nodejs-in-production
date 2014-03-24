template '/etc/init/application.conf' do
  source 'upstart_config.erb'
  mode 0644
  owner 'root'
  group 'root'

  notifies :restart, 'service[application]'

  variables(
    :node_env => node['node_env'],
    :script => node['node_start_script']
  )
end

service 'application' do
  provider Chef::Provider::Service::Upstart
end
