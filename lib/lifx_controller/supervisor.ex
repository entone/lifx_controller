defmodule LifxController.Supervisor do
  use Supervisor
  require Logger

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    Logger.info "Server: #{Application.get_env(:lifx, :tcp_server)}"
    children = [
      worker(LifxController.NetworkListener, []),
    ]
    supervise(children, strategy: :one_for_one)
  end
end
