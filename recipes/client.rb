#
# Cookbook Name:: nomad
# Recipe:: client
#

include_recipe 'nomad::install'
node.default['nomad']['client_enabled'] = true
node.default['nomad']['consul']['client_auto_join'] = true
