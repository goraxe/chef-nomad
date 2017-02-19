#
# Cookbook Name:: nomad
# Recipe:: config
#

user node['nomad']['user'] do
  home  node['nomad']['datadir']
  shell '/bin/false'
  system true
  manage_home true
  only_if { node['nomad']['unprivileged'] }

  action :create
end

# create parents for nomad directories
[
  node['nomad']['datadir'],
  node['nomad']['confdir']
].map {|dir| File.dirname(dir) }.each do |parent|
  directory parent do
    recursive true
    not_if { File.exist?(parent) }
    action :create
  end
end

# create nomad directories
directory node['nomad']['confdir']
directory node['nomad']['datadir'] do
  # don't try to manage directory, it's managed above in this case
  not_if { node['nomad']['unprivileged'] }
  action :create
end

template 'nomad.conf.hcl' do
  path "#{node['nomad']['confdir']}/nomad.conf.hcl"
  variables lazy {
    {
    consul: node['nomad']['consul'].merge({
        client_service_name: node['nomad']['client_service_name'],
        server_service_name: node['nomad']['server_service_name']
      }),
    client: node['nomad']['client'].merge({
        enabled: node['nomad']['client_enabled']
      }),
    server: node['nomad']['server'].merge({
        enabled: node['nomad']['server_enabled']
      }),
    data_dir: node['nomad']['datadir'],
    region: node['nomad']['region'],
    datacenter: node['nomad']['datacenter'],
    bind_addr: node['nomad']['bind_addr'],
    advertise_address: node['nomad']['advertise_address'],
    advertise_ports: node['nomad']['advertise_ports']
  }}

  action :create
end
