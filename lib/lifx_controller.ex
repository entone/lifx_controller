defmodule LifxController do
  use Application
  require Logger

  def start(_type, _args) do
    Logger.info "Starting Lifx Controller"
    LifxController.Supervisor.start_link
  end

end
