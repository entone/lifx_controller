defmodule LifxController do
  use Application

  def start(_type, _args) do
    LifxController.Supervisor.start_link
  end

end
