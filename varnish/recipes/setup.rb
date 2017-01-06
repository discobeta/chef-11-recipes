#
# Cookbook Name:: varnish
# Recipe:: setup
#

include_recipe 'opsworks::setup'

execute 'apt-get update'
package 'varnish'

end