# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # this has to match your ipconfig details
#  if Vagrant.has_plugin?("vagrant-proxyconf")
#    config.proxy.http     = "http://10.233.172.152:3128/"
#    config.proxy.https    = "http://10.233.172.152:3128/"
#    config.proxy.no_proxy = "localhost,127.0.0.1,.example.com,169.254.169.254"
#  end

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "wrap-inno-box"
  config.vm.hostname = "wrap-inno"
  
  config.vm.network :forwarded_port, guest: 80, host: 80
  config.vm.network :forwarded_port, guest: 3000, host: 3010
  config.vm.network :forwarded_port, guest: 5432, host: 5442
  
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

# No need for a bootstrap because it's already set up
#  config.vm.provision :shell, :path => "bootstrap-wrap.sh"
  
end
