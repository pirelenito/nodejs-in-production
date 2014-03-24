bash 'apt_get_update' do
  user 'root'
  environment ({'HOME' => '/root'})
  cwd '/tmp'
  code 'sudo apt-get update'
end

package 'git-core'
package 'bash-completion'
package 'build-essential'

template '/etc/environment' do
  source 'environment.erb'
  owner 'root'
  group 'root'
  mode 0644

  variables(
    :node_env => node['node_env']
  )
end
