# Example 1
#
# Single box with some custom configuration.
#
# NOTE: Make sure you have the precise32 base box installed...
# vagrant box add precise32 http://files.vagrantup.com/precise32.box

Vagrant.configure(2) do |config|
  config.vm.box = "debian/buster64" 
  config.vm.hostname = "hiro"
  config.vm.network :private_network, ip: "192.168.0.202"
  config.vm.synced_folder "src/", "/opt/hiro", type: "nfs"
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "hiro_provision.yml"
    ansible.config_file = "provision.cfg"
  end
end
