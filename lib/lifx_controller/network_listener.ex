defmodule LifxController.NetworkListener do
  use GenServer
  require Logger

  @nerves System.get_env("NERVES")
  @interface System.get_env("INTERFACE")
  @ssid System.get_env("SSID")
  @psk System.get_env("PSK")

  defmodule WifiHandler do
    use GenEvent
    def init(parent) do
      {:ok, %{:parent => parent}}
    end

    def handle_event({:udhcpc, _, :bound, info}, state) do
      Logger.info "Wifi bound: #{inspect info}"
      send(state.parent, {:bound, info})
      {:ok, state}
    end

    def handle_event(_ev, state) do
      {:ok, state}
    end
  end

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def get_ip(interface) do
    Logger.info "Getting IP address for interface #{interface}"
    :inet.getifaddrs()
      |> elem(1)
      |> Enum.filter(fn(intf) -> elem(intf, 0) == to_char_list(interface) end)
      |> Enum.at(0)
      |> elem(1)
      |> Keyword.get(:addr)
  end

  def start_lifx do
    Logger.info "Starting Lifx Client"
    Lifx.Client.start
  end

  def start_wifi do
    Logger.info "Starting Wifi on interface: #{@interface} SSID: #{@ssid}"
    Nerves.InterimWiFi.setup(@interface, ssid: @ssid, key_mgmt: :"WPA-PSK", psk: @psk)
  end

  def init(:ok) do
    GenEvent.add_handler(Nerves.NetworkInterface.event_manager, WifiHandler, self)
    case @nerves do
      "true" -> start_wifi
      _ ->
        ip = System.get_env("INTERFACE") |> get_ip
        Logger.info "Got IP #{inspect ip}"
        start_lifx
    end
    {:ok, %{}}
  end

  def handle_info({:bound, info}, state) do
    Logger.info "IP Address Bound"
    :timer.sleep(1000)
    {:ok, ip} = :inet_parse.address(to_char_list(info.ipv4_address))
    Logger.info "Got IP #{inspect ip}"
    start_lifx
    {:noreply, state}
  end

end
