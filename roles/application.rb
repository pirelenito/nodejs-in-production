name 'application'
description 'Simple Node.js application server with MongoDB'

default_attributes 'node_env' => 'production',
                   'node_start_script' => '/opt/application/index.js'

run_list 'recipe[base]',
         'recipe[ssh]',
         'recipe[swap]',
         'recipe[mongodb]',
         'recipe[nodejs]',
         'recipe[nginx]',
         'recipe[application]',
         'recipe[application::nginx]',
         'recipe[application::nodejs]'
