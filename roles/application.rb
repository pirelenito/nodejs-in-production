name 'application'
description 'Simple Node.js application server with MongoDB'
run_list 'recipe[base]',
         'recipe[ssh]',
         'recipe[swap]',
         'recipe[mongodb]',
         'recipe[nodejs]',
         'recipe[nginx]',
         'recipe[application]',
         'recipe[application::nginx]',
         'recipe[application::nodejs]'
