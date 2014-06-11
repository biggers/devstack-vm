
  #. OpenStack :: DevStack in a VM (Vagrant)
    #. REFs:  https://github.com/lorin/devstack-vm

    #. ==== INSTALL  Vagrant >> 1.3.3+ --  Vagrant "latest"

      cd tarfiles
      wget "vagrant_download url"
      sudo aptitude install ./vagrant_1.6.3_x86_64.deb

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

     $ virtualenv my_openstack_proj  ## create a Py virtualenv, for this test

     $ cd my_openstack_proj
     $ . bin/activate

     $ pip install python-novaclient python-neutronclient

       # ".. Successfully installed python-novaclient python-neutronclient pbr iso8601 PrettyTable requests simplejson six Babel cliff httplib2 pytz cmd2 pyparsing stevedore"

    #. ==== CREATE a cirros instance, in 'Icehouse' DevStack

     $ cd devstack-vm

     $ python boot-cirros.py

     $ deactivate ## we're done with virtual Py env

