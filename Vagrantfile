host_cache_path = File.expand_path("../.cache", __FILE__)
guest_cache_path = "/tmp/vagrant-cache"

Vagrant.configure("2") do |config|
  config.berkshelf.enabled = true
  config.ssh.forward_agent = true
  # Omnibus plugin configuration
  config.omnibus.chef_version = '11.16.2'

  BOX = ENV['BOX'] || 'ubuntu-14.04'
  PROVIDER = ENV['PROVIDER'] || 'virtualbox'

  # Ubuntu Config
  config.vm.define :raxiodemo do |raxiodemo|
    raxiodemo.vm.hostname = "raxiodemo"
    raxiodemo.vm.box = BOX
    raxiodemo.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/#{PROVIDER}/opscode_#{BOX}_chef-provisionerless.box"
    raxiodemo.vm.network "forwarded_port", guest: 8080, host: 8000 # jenkins
    raxiodemo.vm.network "forwarded_port", guest: 9000, host: 8001 # sonar
    raxiodemo.vm.network "forwarded_port", guest: 10000, host: 8002 # jenkins
    raxiodemo.vm.network "private_network", ip: "66.66.66.101"

    raxiodemo.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--cpus", 2]
    end
    raxiodemo.vm.provision :chef_solo do |chef|
      chef.provisioning_path = guest_cache_path
      chef.environments_path = '.chef/environments'
      chef.roles_path = '.chef/roles'
      chef.data_bags_path = 'test/.chef/data_bags'
      chef.cookbooks_path = '.chef/cookbooks'
      chef.environment = 'development'
      chef.run_list = [ "role[development]" ]
    end
    raxiodemo.vm.provision :shell, path: "bootstrap.sh"
    raxiodemo.vm.synced_folder "src/ansible", "/usr/ansible/"
    raxiodemo.vm.synced_folder "src/autocreator", "/usr/autocreator/"
    raxiodemo.vm.provision "file", source: "src/ansible.cfg", destination: "/home/vagrant/.ansible.cfg"
    raxiodemo.vm.provision "file", source: "src/profile", destination: "/home/vagrant/.profile"
    raxiodemo.vm.provision "file", source: "src/raxpub", destination: "/home/vagrant/.raxpub"
    raxiodemo.vm.provision "file", source: "src/ansible_hosts", destination: "/home/vagrant/ansible_hosts"
    raxiodemo.vm.provision "file", source: "src/public_upstream_merge.sh", destination: "/home/vagrant/public_upstream_merge.sh"
    raxiodemo.vm.provision :shell, inline: "cd /usr/autocreator && sudo pip install -rrequirements.txt"
    raxiodemo.vm.provision :shell, inline: "cd /usr/autocreator && sudo ./autocreator.py -d jobs -job raxio_jobs_data -url 'localhost:8080' -http"
    raxiodemo.vm.provision :shell, inline: "sudo mv /home/vagrant/public_upstream_merge.sh /var/lib/jenkins/public_upstream_merge.sh && sudo chmod u+x /var/lib/jenkins/public_upstream_merge.sh && sudo chown jenkins:jenkins /var/lib/jenkins/public_upstream_merge.sh"
    raxiodemo.vm.provision :shell, inline: "sudo cp /usr/ansible/rax.py /usr/share/pyshared/ansible/modules/core/cloud/rackspace/rax.py"
    raxiodemo.vm.provision :shell, inline: "sudo wget https://github.com/aktau/github-release/releases/download/v0.5.3/linux-amd64-github-release.tar.bz2 && sudo tar xjf linux-amd64-github-release.tar.bz2 && sudo chown -R jenkins:jenkins bin && sudo mv bin /var/lib/jenkins/"
    raxiodemo.vm.provision :shell, inline: "sudo cp /home/vagrant/.raxpub /var/lib/jenkins/.raxpub && sudo chown jenkins:jenkins /var/lib/jenkins/.raxpub"
    raxiodemo.vm.provision :shell, inline: "sudo cp /home/vagrant/.profile /var/lib/jenkins/.profile && sudo chown jenkins:jenkins /var/lib/jenkins/.profile"
  end

end
