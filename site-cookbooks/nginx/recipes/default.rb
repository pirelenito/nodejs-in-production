package 'nginx' do
  action :install
end

service 'nginx' do
  supports :status => true, :start => true, :stop => true
end

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf'
  mode 0644
  owner 'root'
  group 'root'

  notifies :restart, 'service[nginx]'
end

link '/etc/nginx/sites-enabled/default' do
  action :delete
end
