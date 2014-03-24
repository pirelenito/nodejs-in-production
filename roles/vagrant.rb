name 'vagrant'
description 'Node.js development environment with MondoDB'

default_attributes 'node_env' => 'development',
                   'node_start_script' => '/vagrant/index.js'

run_list 'recipe[base]',
         'recipe[mongodb]',
         'recipe[genghisapp]',
         'recipe[nodejs]',
         'recipe[knife-solo]',
         'recipe[main_vagrant]'

