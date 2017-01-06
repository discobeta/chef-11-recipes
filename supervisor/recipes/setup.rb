#
# Cookbook Name:: supervisor
# Recipe:: setup
#

node.default['supervisor']['version'] = '3.3.1'
node.default['supervisor']['loglevel'] = 'warn'
node.default['supervisor']['minfds'] = 4096
include_recipe 'supervisor'
execute 'service supervisor restart'