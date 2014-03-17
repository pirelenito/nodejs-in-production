template "/etc/init/application.conf" do
  source "upstart_config.erb"
  mode 0644
  owner "root"
  group "root"

  notifies :restart, "service[application]"

  variables(
    :node_env => 'production',
    :script => '/opt/application/index.js'
  )
end

service 'application' do
  provider Chef::Provider::Service::Upstart
end
