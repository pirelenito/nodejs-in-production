# MongoDB instalationg instruction based from
# http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/

bash 'add_mongodb_repository' do
  user 'root'
  environment ({'HOME' => '/root'})
  cwd '/tmp'
  not_if 'test -f /usr/bin/mongo'
  code <<-EOH
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
    echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
    sudo apt-get update
  EOH
end

package 'mongodb-10gen'

service 'mongodb' do
  supports :status => true, :start => true, :stop => true
end

template '/etc/mongodb.conf' do
  source 'mongodb.conf.erb'
  mode 0644
  owner 'root'
  group 'root'

  notifies :restart, 'service[mongodb]'
end
