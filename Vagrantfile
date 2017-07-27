VAGRANTFILE_API_VERSION = "2"

# Virtualbox mount a drive (if not using Vagrant sync_folder)
# 1. Create machine folder or transient folder, git it a name, wd for example
# 2. On guest OS create a folder to mount the share, mkdir -p /tmp/wd
# 3. sudo mount -t vboxsf wd /tmp/wd/

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  install_elixir =<<EOF
wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && sudo dpkg -i erlang-solutions_1.0_all.deb
sudo apt-get update
sudo apt-get install esl-erlang -y
sudo apt-get install elixir -y
EOF

  install_node =<<EOF
# Node 6 curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
# Node 8 curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -  
sudo apt-get update
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -  
sudo apt-get install nodejs -y
sudo apt-get install npm -y
sudo apt-get install build-essential -y
EOF

  install_inotify_tools =<<EOF
sudo apt-get update
sudo apt-get install inotify-tools -y
EOF

  install_postgresql =<<EOF
sudo apt-get update
sudo apt-get install postgresql postgresql-contrib -y
EOF

  config.vm.box = "ubuntu/trusty64"

  config.vm.define "ubuntu" do |v|
    v.vm.provider "virtualbox" do |vb|
      vb.customize ["setextradata", "global", "GUI/SuppressMessages", "all" ]
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
      vb.cpus = 1
      vb.memory = 1024
      vb.linked_clone = true
    end
    v.vm.hostname = "phoenix"
    v.vm.network "private_network", ip: "172.20.20.10"
    v.vm.network 'forwarded_port', id: 'phoenix', host_ip: '127.0.0.1', host: 4000, guest: 4000, protocol: 'tcp'
  end
  config.vm.provision "shell", inline: install_elixir
  config.vm.provision "shell", inline: install_node
  config.vm.provision "shell", inline: install_inotify_tools
  config.vm.provision "shell", inline: install_postgresql  
  config.vm.provision "file", source: "./create_testapp.sh", destination: "/tmp/create_testapp.sh"
  config.vm.provision "shell" do |shell|
    shell.inline = "chmod +x /tmp/create_testapp.sh"
    shell.privileged = true
  end
end
