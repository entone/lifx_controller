use Mix.Config
require Logger

config :logger,
  level: :debug

config :lifx,
  tcp_server: false,
  tcp_port: 8800

config :lifx_controller, interface: :wlan0

config :nerves_network,
  regulatory_domain: "US"

key_mgmt = System.get_env("NERVES_NETWORK_KEY_MGMT") || "WPA-PSK"

Logger.info System.get_env("SSID")

config :nerves_network, :default,
  wlan0: [
    ssid: System.get_env("SSID"),
    psk: System.get_env("PSK"),
    key_mgmt: String.to_atom(key_mgmt)
  ],
  eth0: [
    ipv4_address_method: :dhcp
]

config :nerves, :firmware,
  rootfs_overlay: "rootfs_overlay"


# import_config "#{Mix.Project.config[:target]}.exs"
