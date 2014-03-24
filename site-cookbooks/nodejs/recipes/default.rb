bash 'node_install' do
  user 'root'
  cwd '/tmp'
  not_if 'test -f /opt/nodejs'
  code <<-EOH
    wget http://nodejs.org/dist/v0.10.26/node-v0.10.26-linux-x64.tar.gz
    tar xvzf node-v0.10.26-linux-x64.tar.gz
    mv node-v0.10.26-linux-x64 /opt/nodejs
    sudo /opt/nodejs/bin/npm install -g grunt-cli supervisor
  EOH
end
