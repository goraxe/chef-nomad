#
# Cookbook Name:: nomad
# Recipe:: server
#

include_recipe 'nomad::install'
node.default['nomad']['server_enabled'] = true
node.default['nomad']['consul']['server_auto_join'] = true
