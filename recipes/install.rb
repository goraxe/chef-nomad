#
# Cookbook Name:: nomad
# Recipe:: install
#

include_recipe 'nomad::config'


ver = node['nomad']['version']
checksum = node['nomad']['version_checksums'][ver]
nomad_zip = "#{node['nomad']['datadir']}/nomad.zip"

package 'unzip'

remote_file 'nomad.zip' do
  path nomad_zip
  source "https://releases.hashicorp.com/nomad/#{ver}/nomad_#{ver}_linux_amd64.zip"
  checksum checksum
  backup false
  action :create
end

execute 'unzip nomad' do
  command "unzip -o #{nomad_zip} -d /usr/bin"
  subscribes :run, 'remote_file[nomad.zip]'
  action :nothing
end

service_manager 'nomad' do
  supports status: true, reload: false
  user node['nomad']['unprivileged'] ? node['nomad']['user'] : 'root'
  group node['nomad']['unprivileged'] ? node['nomad']['user'] : 'root'

  variables(
    config: node['nomad']['confdir'],
    nofile: node['nomad']['nofile']
  )

  subscribes :restart, 'remote_file[nomad.zip]'
  subscribes :restart, 'template[nomad.conf.hcl]'
  action :start
end
