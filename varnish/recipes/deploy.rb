#
# Cookbook Name:: varnish
# Recipe:: deploy
#

include_recipe 'supervisor::setup'

node[:deploy].each do |application, deploy|

  if eploy[:custom_type] != 'varnish'
    Chef::Log.debug("Skipping application #{application} as it is not a Varnish deployment")
    next
  end

  app_path = ::File.join(deploy['deploy_to'], 'current')

  # Clone latest application source code from git
  opsworks_deploy do
    deploy_data deploy
    app application
  end

  # Clear stale node_modules
  # directory ::File.join(app_path, 'node_modules') do
  #   action :delete
  #   recursive true
  # end

  # Install all the dependencies listed in package.json
  # execute 'npm install' do
  #   cwd app_path
  # end

  # Create config.json file
  template ::File.join(app_path, 'etc', 'default.vcl') do
    source 'default.vcl.erb'
    cookbook 'varnish'
    owner deploy['user']
    group deploy['group']
    mode 0644
    variables Hash.new
    variables.update deploy
    variables.update :varnish => node[:varnish]
  end

  execute 'rm /etc/supervisor.d/*' do
    ignore_failure true
  end

  # Configure supervisor
  supervisor_service "#{application}-server" do
    action :enable
    command '/usr/sbin/varnishd -a :80 -T localhost:6082 -f /etc/varnish/default.vcl -S /etc/varnish/secret -s malloc,4g'
    directory app_path
    user deploy['user']
    redirect_stderr true
    environment Hash.new({:NODE_ENV => 'production'})
  end

  # Group programs so that they can be controlled together
  supervisor_group application do
    group_name application
    programs ["#{application}-server"]
  end
end