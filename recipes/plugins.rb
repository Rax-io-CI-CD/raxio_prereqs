template "/var/lib/jenkins/gerrit-trigger.xml" do
  source "gerrit-trigger.xml.erb"
  mode "0644"
  owner "jenkins"
  group "jenkins"
  notifies :restart, 'service[jenkins]', :delayed
  variables(
    :gerrit_host_name => 'raxio2015-gerrit.dimitryushakov.com' ,
    :gerrit_host_port => 29418,
    :gerrit_user_name => 'raxio-demo',
    :gerrit_email => 'dimalg@gmail.com'
  )
end

template "/var/lib/jenkins/hudson.plugins.git.GitSCM.xml" do
  source "hudson.plugins.git.GitSCM.xml.erb"
  mode "0644"
  owner "jenkins"
  group "jenkins"
  notifies :restart, 'service[jenkins]', :delayed
  variables(
    :global_config_name => 'builds' ,
    :global_config_email => 'builds@raxio2015-gerrit.dimitryushakov.com'
  )
end

template "/var/lib/jenkins/hudson.plugins.sonar.SonarPublisher.xml" do
  source "hudson.plugins.sonar.SonarPublisher.xml.erb"
  mode "0644"
  owner "jenkins"
  group "jenkins"
  notifies :restart, 'service[jenkins]', :delayed
  variables(
    :name => 'raxio-sonar-test',
    :server_url => 'http://localhost:8001',
    :database_url => 'jdbc:h2:tcp://localhost:9092/sonar',
    :database_driver => '',
    :database_login => 'admin',
    :database_password => 'admin'
  )
end

template "/var/lib/jenkins/hudson.plugins.sonar.SonarRunnerInstallation.xml" do
  source "hudson.plugins.sonar.SonarRunnerInstallation.xml.erb"
  mode "0644"
  owner "jenkins"
  group "jenkins"
  notifies :restart, 'service[jenkins]', :delayed
end

template "/var/lib/jenkins/org.jenkinsci.plugins.ghprb.GhprbTrigger.xml" do
  source "org.jenkinsci.plugins.ghprb.GhprbTrigger.xml.erb"
  mode "0644"
  owner "jenkins"
  group "jenkins"
  notifies :restart, 'service[jenkins]', :delayed
  variables(
    :username => 'USERNAME',
    :password => 'PASSWORD',
    :access_token => 'ACCESS_TOKEN',
    :admin_list => 'ADMIN_LIST',
    :published_url => 'http://ci.dimitryushakov.com/'
  )
end
