# Node.js development and production boxes

This repository provides the foundation to start developing Node.js applications.

It uses [Vagrant](https://www.vagrantup.com) and [knife-solo](http://matschaffer.github.io/knife-solo/) to setup development and production boxes respectively.

**During development** you will get a Vagrant box with:

 * [Node.js](http://nodejs.org);
 * [MongoDB](http://mongodb.org);
 * [Genguis](http://genghisapp.com): an amazing MongoDB admin UI;
 * [knife-solo](http://matschaffer.github.io/knife-solo/): utility to provision your production boxes.

And **in production** you will get a box with:

 * [Nginx](http://nginx.org) as the web server (acting as a proxy to the application);
 * [Node.js](http://nodejs.org);
 * [MongoDB](http://mongodb.org) setup only to accept local connections;
 * SSH setup with authorized_keys;
 * Application deployment support using [git hooks](http://git-scm.com/book/en/Customizing-Git-Git-Hooks).

It should be a **simple** and solid foundation to get you started on Node.js development and server provisioning.

All the cookbooks presented are very simple (not maxing 20 lines of code), demostrating that it can be possible to provision machines using Chef without the use of complex third-party cookbooks (Berkshelf or Librarian).

You can check how each cookbook work and see how little code is required to install something like Nginx by simply relying on the default Ubuntu package.

The Node.js **server must listen to port 3000** for the Nginx proxy and Vagrant port-forwarding to work.

## Development with Vagrant

To get started you will need [Virtual Box](https://www.virtualbox.org) and [Vagrant](https://www.vagrantup.com) installed. These are the only dependencies that require manual instalation, everything else is automated.

Once Vagrant is installed, you can start the development machine with:

```shell
vagrant up
```

This will download a [base box](https://docs.vagrantup.com/v2/boxes.html) from the internet and provision the machine using the recipes that are specified at the `roles/vagrant.rb` file.

Once completed, you can log in the machine and start working.

```shell
vagrant ssh
```

For more information on Vagrant, please check its [excelent documentation](https://docs.vagrantup.com/v2/boxes.html).

## Server provisioning with knife-solo

Once you've got the first working version of your application, you can put it into production using the [knife-solo](http://matschaffer.github.io/knife-solo/) utility that is already installed inside the Vagrant development box.

You will need a Ubuntu box with root access. A good way of getting a machine is using a VPS provider (like [Digital Ocean](https://www.digitalocean.com)).

Once you've got the machine, we need to prepare it before cooking the recipes. Using the knife-solo tool it is easy as:

```shell
knife solo prepare root@myRemoteMachineAddress
```

Pay attention to the `myRemoteMachineAddress`, change it to the machine address.

### Configuring the data bags

Data bags is Chef's way of storing **sensitive information**, and it is usually **not a good idea to commit** its contents.

The only data bag in this project is the one used to hold you public ssh key. Make sure to use the sample file as a reference to create your own `authorised_keys.json` file.

### Cooking the recipes

Once chef is installed, we can cook the recipes.

```shell
knife solo cook root@myRemoteMachineAddress -r "role[application]"
```

The `role[application]` represents the role of this machine, or in other words, which cookbooks we will be running in it. You can check the `roles/application.rb` file to see how it works.

Once completed, you will have the machine ready to host the application.

### Application Deployment

The deployment works via git-hooks. So once the server detects the push, it installs the dependencies (`npm install`) and restarts the server.

To deploy a application in this shiny new server you need to add a new remote to your application repository.

```shell
git remote add deploy deploy@myRemoteMachineAddress:/opt/application/.git
```

As you can see, the application is located at the `/opt/application` server folder.

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
