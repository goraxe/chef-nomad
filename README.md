# Chef nomad cookbook

Cookbook configures and installs [nomad](https://nomadproject.io) agent  on your machine. Aiming to be minimalist the cookbook downloads nomad agent, configures files, writes and starts up system services.

Note that this cookbook doesn't provide all possible configuration scenarios it expects your setup to work with **consul** and  creates fixed sketched configuration for it (though quite tunable via attributes).

## Supported Platforms

No  restrictions, but works only on systems with upstart or systemd.

## Attributes

|Key|Description|Default|
|---|---|---|
|client_enabled|Enables client mode. You can use this attribute instead of adding corresponding recipe|`false`|
|server_enabled|Enables server mode. You can use this attribute instead of adding corresponding recipe|`false`|
|bind_addr|Nomad agent bind address.|`"0.0.0.0"`|
|advertise_address|Nomad agent advertise address.|`node['ipadddress']`|
|consul.address|Consul server address|`node['ipaddress']:8500`|

For other attributes availability it's suggested to dig into [the attributes file](attributes/default.rb).

## Usage

Recipes:

 - **nomad::default (nomad::client)** - installs and configures nomad agent in **client mode**.
 - **nomad::server** - installs and configures nomad agent in **server mode**.

Include either of recipes or both of them into your **run_list** to install nomad and get particular nomad agent mode configured.

## License and Authors

Author:: Denis Baryshev (<dennybaa@gmail.com>)
