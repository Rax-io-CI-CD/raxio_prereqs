include_recipe 'jenkins::master'

template "/var/lib/jenkins/config.xml" do
  source "config.xml.erb"
  mode "0644"
  owner "jenkins"
  group "jenkins"
  notifies :restart, 'service[jenkins]', :delayed
  variables(
    :lists => [
      {
        :name => 'Nightly Build Flow',
        :jobs => [
          'raxio_jobs_data_build',
          'raxio_jobs_data_cleanup',
          'raxio_jobs_data_functional_tests',
          'raxio_jobs_data_master_build_flow',
          'raxio_jobs_data_performance_tests',
          'raxio_jobs_data_public_upstream_merge',
          'raxio_jobs_data_snapshot_deployer',
          'raxio_jobs_data_sonar',
          'raxio_jobs_data_unit_tests'
        ]
      },
      {
        :name => 'Upstream Build Flow',
        :jobs => [
          'raxio_jobs_data_build',
          'raxio_jobs_data_cleanup',
          'raxio_jobs_data_functional_tests',
          'raxio_jobs_data_performance_tests',
          'raxio_jobs_data_unit_tests',
          'raxio_jobs_data_upstream_patch_build_flow',
          'raxio_jobs_data_upstream_patch_trigger'
        ]
      },
      {
        :name => 'Internal Patch Build Flow',
        :jobs => [
          'raxio_jobs_data_build',
          'raxio_jobs_data_cleanup',
          'raxio_jobs_data_downstream_patch_build_flow',
          'raxio_jobs_data_downstream_patch_trigger',
          'raxio_jobs_data_functional_tests',
          'raxio_jobs_data_performance_tests',
          'raxio_jobs_data_unit_tests'
        ]
      },
      {
        :name => 'Deployer',
        :jobs => [
          'raxio_jobs_data_blue_node_deployment_build_flow',
          'raxio_jobs_data_blue_nodes_deployer',
          'raxio_jobs_data_blue_nodes_deployer_rescue',
          'raxio_jobs_data_green_node_deployment_build_flow',
          'raxio_jobs_data_green_nodes_deployer',
          'raxio_jobs_data_green_nodes_deployer_rescue',
          'raxio_jobs_data_release_deployer',
          'raxio_jobs_data_release_deployer_cleanup'
        ]
      }
    ]
  )
end

jenkins_plugin 'build-flow-plugin' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'ruby-runtime' do
  notifies :restart, 'service[jenkins]', :immediately
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
  version '2.3.5'
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'github-api' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'github' do
  version '1.11'
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
jenkins_plugin 'build-flow-plugin' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'sonar' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'ssh-agent' do
  notifies :restart, 'service[jenkins]', :delayed
end
jenkins_plugin 'ssh-credentials' do
  notifies :restart, 'service[jenkins]', :delayed
end

jenkins_plugin 'ssh' do
  notifies :restart, 'service[jenkins]', :delayed
end

include_recipe 'raxio::plugins'

include_recipe 'sonarqube::default'

remote_file '/opt/sonarqube-5.0/extensions/plugins/sonar-python-plugin-1.3.jar' do
  source 'http://repository.codehaus.org/org/codehaus/sonar-plugins/python/sonar-python-plugin/1.3/sonar-python-plugin-1.3.jar'
  action :create_if_missing
  notifies :restart, "service[sonarqube]", :delayed
end

remote_file '/opt/sonarqube-5.0/extensions/plugins/sonar-generic-coverage-plugin-1.1.jar' do
  source 'http://repository.codehaus.org/org/codehaus/sonar-plugins/sonar-generic-coverage-plugin/1.1/sonar-generic-coverage-plugin-1.1.jar'
  action :create_if_missing
  notifies :restart, "service[sonarqube]", :delayed
end

remote_file '/opt/sonarqube-5.0/extensions/plugins/sonar-scm-stats-plugin-0.3.1.jar' do
  source 'http://repository.codehaus.org/org/codehaus/sonar-plugins/sonar-scm-stats-plugin/0.3.1/sonar-scm-stats-plugin-0.3.1.jar'
  action :create_if_missing
  notifies :restart, "service[sonarqube]", :immediately  
end
