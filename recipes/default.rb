#
# Cookbook Name:: nomad
# Recipe:: default
#

include_recipe 'nomad::client'
include_recipe 'nomad::server' if node['nomad']['server_enabled']
