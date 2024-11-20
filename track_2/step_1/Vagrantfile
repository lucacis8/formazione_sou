Vagrant.configure("2") do |config|
  # Specifica la box Rocky Linux 9
  config.vm.box = "rockylinux/9"

  # Configurazione rete: rete privata e porte forwardate
  config.vm.network "private_network", type: "static", ip: "192.168.56.10"
  config.vm.network "forwarded_port", guest: 8080, host: 8080  # Porta per Jenkins
  config.vm.network "forwarded_port", guest: 50000, host: 50000  # Porta per agenti Jenkins

  # Configurazione risorse virtuali
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"  # RAM della VM
    vb.cpus = 2         # Numero di CPU
  end

  # Provisioning tramite Ansible
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provision.yml"
    ansible.compatibility_mode = "2.0"
  end
end
