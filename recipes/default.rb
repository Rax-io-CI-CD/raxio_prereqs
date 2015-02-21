include_recipe 'jenkins::master'

jenkins_plugin 'build-flow-plugin' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'build-environment' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'conditional-buildstep' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'dashboard-view' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'envinject' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'gatling' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'gerrit-trigger' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'git-client' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'git-parameter' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'git' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'github-api' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'github' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'ghprb' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'groovy' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'ircbot' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'instant-messaging' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'multiple-scms' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'notification' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'parameterized-trigger' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'pyenv' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'python' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'python-wrapper' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'run-condition' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'shiningpanda' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'sonargraph-plugin' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'ssh-agent' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'ssh-credentials' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'ssh' do
  notifies :restart, 'service[jenkins]', :immediately
end

include_recipe 'sonarqube::default'
