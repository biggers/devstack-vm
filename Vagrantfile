# -*- coding: utf-8 -*-
# -*- mode: ruby -*-  
# vi: set ft=ruby :

# after a 'vboxsf' (/Vagrant) mount failure:
# sudo ln -s /opt/VBoxGuestAdditions-4.3.10/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions
# vagrant reload
#
# wget https://www.virtualbox.org/download/testcase/VBoxGuestAdditions_4.3.11-93070.iso‌

Vagrant.configure("2") do |config|

    # ... because 14.04 Trusty "cloudimg" won't fly, with DevStack "Icehouse"
    config.vm.box = "puppetlabs/ubuntu-13.10-64-puppet"
    config.vm.hostname = "devstack"

    # eth1, this will be the endpoint
    config.vm.network :private_network, ip: "192.168.27.100"

    # eth2, this will be the OpenStack "public" network, use DevStack default
    config.vm.network :private_network, ip: "172.24.4.225", :netmask => "255.255.255.224", :auto_config => false

    config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", 6656]
        vb.customize ["modifyvm", :id, "--cpus", "2"]
       	# eth2 must be in promiscuous mode for floating IPs to be accessible
       	vb.customize ["modifyvm", :id, "--nicpromisc3", "allow-all"]
        vb.customize ["modifyvm", :id, "--uart1", "0x3F8", 4]
        vb.gui = true
    end
    config.vm.provision :ansible do |ansible|
        ansible.host_key_checking = false
        ansible.playbook = "devstack.yaml"
        ansible.verbose = "v"
    end
    config.vm.provision :shell, :inline => "cd devstack; sudo -u vagrant env HOME=/home/vagrant ./stack.sh"
    config.vm.provision :shell, :inline => "ovs-vsctl add-port br-ex eth2"

    # Workaround for https://bugs.launchpad.net/devstack/+bug/1243075
    config.vm.provision :ansible do |ansible|
        ansible.host_key_checking = false
        ansible.playbook = "horizon-workaround.yaml"
        ansible.verbose = "v"
    end
end
