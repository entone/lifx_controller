use Mix.Config

config :logger,
  level: :info

config :lifx,
  tcp_server: true,
  tcp_port: 8800

config :nerves_interim_wifi,
  regulatory_domain: "US"

config :nerves, :firmware,
  fwup_conf: "config/rpi2/fwup.conf",
  rootfs_additions: "config/rpi2/rootfs-additions"


# import_config "#{Mix.Project.config[:target]}.exs"
