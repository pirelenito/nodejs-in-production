# Genghisapp is an amazing MongoDB admin app
# check it out at: http://genghisapp.com

package 'ruby1.9.3'
gem_package 'bson_ext'
gem_package 'genghisapp'

template '/etc/init/genghisapp.conf' do
  source 'genghisapp.conf'
  mode 0644
  owner 'root'
  group 'root'

  notifies :restart, 'service[genghisapp]'
end

service 'genghisapp' do
  provider Chef::Provider::Service::Upstart
end
