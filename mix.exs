defmodule LifxController.Mixfile do
  use Mix.Project

  @target System.get_env("MIX_TARGET") || "host"

  def project do
    [
      app: :lifx_controller,
      version: "0.1.0",
      elixir: "~> 1.5",
      target: @target,
      archives: [nerves_bootstrap: "~> 1.0"],
      deps_path: "deps/#{@target}",
      build_path: "_build/#{@target}",
      lockfile: "mix.lock.#{@target}",
      start_permanent: Mix.env() == :prod,
      aliases: [loadconfig: [&bootstrap/1]],
      deps: deps()
    ]
  end

  def application do
    [
      mod: {LifxController, []},
      applications: [:logger, :lifx] ++ applications(@target)
   ]
  end

  def bootstrap(args) do
    Application.start(:nerves_bootstrap)
    Mix.Task.run("loadconfig", args)
  end

  def applications("rpi3") do
    [:nerves_network, :nerves_runtime]
  end
  def applications(_), do: []

  def deps do
    [
      {:nerves, "~> 1.0", runtime: false},
      {:lifx, "~> 0.1.8"},
    ] ++ deps(@target)
  end

  def deps("host"), do: []
  def deps("rpi3") do
    [
      {:nerves_network, "~> 0.3.6"},
      {:nerves_runtime, "~> 0.4"},
      {:nerves_system_rpi3, "~> 1.1", runtime: false},
      {:nerves_toolchain_arm_unknown_linux_gnueabihf, "~> 1.0", runtime: false},
    ]
  end

end
