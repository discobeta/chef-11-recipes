#
# Cookbook Name:: supervisor
# Recipe:: stop
#

node[:deploy].each do |application, deploy|

  # Restart supervisor
  supervisor_group application do
    action :stop
  end
end
