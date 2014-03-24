# Node.js  Provisioning

Provisions a machine with **MongoDB** that accepts **Node.js** application deployment using **git hooks**.

Once provisioned, you can push the application code to the machine and watch in run.

The main purpose of this project is to demonstrate how easy it is to make the provisioning of a machine using custom cookbooks, instead of complex third-party cookbooks via Berkshelf or Librarian.

You can check how each cookbook work and see how little code is required to install something like Nginx by simply relying on the default Ubuntu package.

You will need [knife-solo](http://matschaffer.github.io/knife-solo/) installed before continuing.

**THIS IS A WORK IN PROGRESS, SO IT MIGHT NOT WORK YET.**

## Preparing a new Machine

You will need a Ubuntu box with root access. A good way of getting a machine is using a VPS provider, like [Digital Ocean](https://www.digitalocean.com).

Once you get a machine, we need to prepare it before cooking our recipes. Using the knife-solo tool installed earlier:

```shell
knife solo prepare root@myRemoteMachineAddress
```

## Configuring the data bags

Data bags is Chef way of storing **sensitive information**. It is usually **not a good idea to commit** the contents stored here.

The only data bag in this project is the one used to hold you public ssh key. Make sure to use the sample file as a reference to create your own `authorised_keys.json` file.

## Cooking the recipes

Once chef is installed, we can cook the recipes.

```shell
knife solo cook root@myRemoteMachineAddress roles/application.json
```

Pay attention to the *myRemoteMachineAddress*, change it to your machine address.

The *roles/application.json* represents the role of this machine, or in other words, which cookbooks we will be running in it. You can check its content to see how it works.

The important piece is the `run_list` attribute displayed bellow:

```json
{
  "run_list": [
    "recipe[base]",
    "recipe[ssh]",
    "recipe[swap]",
    "recipe[mongodb]",
    "recipe[nodejs]",
    "recipe[nginx]",
    "recipe[application]",
    "recipe[application::nginx]",
    "recipe[application::nodejs]"
  ]
}
```

Once completed, you will have a machine with Nginx, NodeJS and MongoDB to host you application.

## Deployment

The deployment works via git-hooks. So once the server detects the push, it installs the dependencies and restarts the server.

To deploy a application in this shiny new server you need to add a new remote to your application repository.

```shell
git remote add deploy deploy@myRemoteMachineAddress:/opt/application/.git
```

Then you can push the code and watch it works!

```shell
git push deploy master
```

The server expects that the application server is executed via a `index.js` file in `production` environment. But you can change that in the `roles/application.rb` file at:

```ruby
default_attributes 'node_env' => 'production',
                   'node_start_script' => '/opt/application/index.js'
```

##  Acknowledgment

* [Louis Chatriot](https://github.com/louischatriot) for his Upstart script;
* [Felipe Munhoz](https://github.com/fnmunhoz) (my chef mentor).
