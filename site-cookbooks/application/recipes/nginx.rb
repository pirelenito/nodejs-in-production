template '/etc/nginx/sites-available/application' do
  source 'nginx_config.erb'
  mode 0644
  owner 'root'
  group 'root'
  notifies :restart, 'service[nginx]'
end

link '/etc/nginx/sites-enabled/application' do
  to '/etc/nginx/sites-available/application'
  notifies :restart, 'service[nginx]'
end

