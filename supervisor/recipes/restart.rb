#
# Cookbook Name:: supervisor
# Recipe:: restart
#

node[:deploy].each do |application, deploy|

  # Restart supervisor
  supervisor_group application do
    action :restart
  end
end