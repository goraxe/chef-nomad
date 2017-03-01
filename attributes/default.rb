default['nomad']['version'] = '0.4.1'
default['nomad']['version_checksums'] = {
  '0.4.1' => '0cdb5dd95c918c6237dddeafe2e9d2049558fea79ed43eacdfcd247d5b093d67',
  '0.5.4' => 'ed9eb471b9f5bab729cfa402db5aa56e1d935c328ac48327267e0ea53568d5c2'
}


default['nomad']['user'] = 'nomad'
default['nomad']['unprivileged'] = true
default['nomad']['nofile'] = 1024

## ----- Directly specified options (overwrite nomad.{section}.{option} if that is given)
#
default['nomad']['datadir'] = '/var/lib/nomad'
default['nomad']['confdir'] = '/etc/nomad'

default['nomad']['server_service_name'] = 'nomad'
default['nomad']['client_service_name'] = 'nomad-client'

# These two can be switch on by corresponding recipes
default['nomad']['client_enabled'] = false
default['nomad']['server_enabled'] = false

default['nomad']['bind_addr'] = '0.0.0.0'
default['nomad']['region'] = 'global'
default['nomad']['datacenter'] = 'dc1'
default['nomad']['advertise_address'] = node['ipaddress']
default['nomad']['advertise_ports'] = {
  http: 4646,
  rpc: 4647,
  serf: 4648
}


## ----- Default input for HCL config sections
#
default['nomad']['consul'] = {
  address: "#{node[:ipaddress]}:8500",
  server_auto_join: false,
  client_auto_join: true
}

default['nomad']['client'] = {
  node_class: "",
  network_speed: 0,
  chroot_env: {},
  reserved: {
    memory: 0,
    cpu:    0,
    disk:   0,
    reserved_ports: []
  },
  meta: {},
  options: {
    'driver.raw_exec.enable' => 0
  }
}

default['nomad']['server'] = {
  bootstrap_expect: 1
}
