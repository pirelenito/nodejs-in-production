directory '/opt/application/' do
  owner 'deploy'
  group 'deploy'
  mode '0775'
  recursive true
  action :create
end

bash 'application_git' do
  user 'deploy'
  cwd '/tmp'
  not_if 'test -f /opt/application/.git'
  code <<-EOH
    git init --bare /opt/application/.git
  EOH
end

template '/opt/application/.git/hooks/post-receive' do
  source 'git_hook'
  mode 0550
  owner 'deploy'
  group 'deploy'
end
