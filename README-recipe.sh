
  #. OpenStack :: DevStack in a VM (Vagrant)

    #. REFs:  https://github.com/lorin/devstack-vm

    #. ==== INSTALL Virtualbox, but *NOT* 4.3.10 (guest mounts fail!)

      #. https://www.virtualbox.org/wiki/Linux_Downloads

    #. ==== INSTALL  Vagrant >> 1.3.3+ --  Vagrant "latest"
      #. w/ 'vbguest' plugin - esp for Linux (kernel updates / DKMS)

      cd tarfiles
      wget "vagrant_download url"
      sudo aptitude install ./vagrant_1.6.3_x86_64.deb

      vagrant plugin install vagrant-vbguest

    #. ===== INSTALL latest Ansible (on Ubuntu, or Mac)

      #. SEE Ref:  http://docs.ansible.com/intro_installation.html


    #. ==== Bring up  < DevStack >
     $ git clone "the devstack-vm project"

     $ cd devstack-vm
     $ vagrant up

    #. ==== INSTALL Py client modules (in a "virtual Py env"), for OpenStack

    #. FOR MacOS X - FOLLOW:
     #. http://hackercodex.com/guide/python-development-environment-on-mac-osx/

     $ aptitude install python-virtualenv  

     $ cd devstack-vm
     $ virtualenv .	## here, create a Py virtualenv, for DevStack Py client

     $ . bin/activate

     $ pip install python-novaclient python-neutronclient

       # ".. Successfully installed python-novaclient python-neutronclient pbr iso8601 PrettyTable requests simplejson six Babel cliff httplib2 pytz cmd2 pyparsing stevedore"


    #. ==== CREATE a cirros instance, in 'Icehouse' DevStack

     $ cd devstack-vm

     $ python boot-cirros.py

     $ deactivate ## we're done with virtual Py env

   #. ==== BUGS / "features"

     #. -- Can't connect to Cirros instances on 172.24.4.x network
     #. -- Can't login to 'cirros' instance with specified login & password


  #. ====  OpenStack services **DO NOT restart**, upon vg halt; vg up !!

     #. ... Login to 'devstack'.   Run:  (and see 'Vagrantfile')
     #.
     vagrant halt
     vagrant up

     ssh devstack  # as user 'vagrant', see SSH config entry, below

     #. Just RESTART all DevStack services

     cd devstack; sudo -u vagrant env HOME=/home/vagrant ./rejoin-stack.sh

     #. ==>> OR

     #. RECREATE all the databases, LOSING data of all the images,
     #  users, instances, ...

     cd devstack; sudo -u vagrant env HOME=/home/vagrant ./stack.sh

	# "Horizon is now available at http://192.168.27.100/
	#  Keystone is serving at http://192.168.27.100:5000/v2.0/
	#  Examples on using novaclient command line is in exercise.sh
	#  The default users are: admin and demo
	#  The password: xxxxxxx
	#  This is your host ip: 192.168.27.100
	#  stack.sh completed in 372 seconds."


    #. ==== your-desktop SSH 'config' entry -- easily login to 'devstack' host VM


# $HOME/.ssh/config   -- DevStack host
#  "DevStack on Vagrant / virtualbox"
#
Host devstack
     Hostname 192.168.27.100
     Port 22
     User vagrant
     Compression no
     Ciphers blowfish-cbc,arcfour256
     UserKnownHostsFile /dev/null
     StrictHostKeyChecking no
     PasswordAuthentication no
     IdentityFile "/home/YOUR_USER/.vagrant.d/insecure_private_key"
     IdentitiesOnly yes
