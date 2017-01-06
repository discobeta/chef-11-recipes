#
# Cookbook Name:: supervisor
# Recipe:: start
#

node[:deploy].each do |application, deploy|

  # Restart supervisor
  supervisor_group application do
    action :start
  end
end
