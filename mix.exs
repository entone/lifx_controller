defmodule LifxController.Mixfile do
  use Mix.Project

  @target System.get_env("NERVES_TARGET") || "rpi2"

  def project do
    [app: :lifx_controller,
     version: "0.0.1",
     target: @target,
     archives: [nerves_bootstrap: "~> 0.1.4"],
     deps_path: "deps/#{@target}",
     build_path: "_build/#{@target}",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps ++ system(@target)]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {LifxController, []},
      applications: [:logger, :nerves, :nerves_system_rpi2, :nerves_interim_wifi, :lifx]
   ]
  end

  def deps do
    [
      {:nerves, "~> 0.3.0"},
      {:nerves_system_rpi2, "~> 0.6.1"},
      {:nerves_interim_wifi, "~> 0.1.0"},
      {:lifx, "~> 0.1.7"}
    ]
  end

  def system(target) do
    [{:"nerves_system_#{target}", ">= 0.0.0"}]
  end

  def aliases do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end

end
