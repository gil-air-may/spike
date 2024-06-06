defmodule Spike.Message do
  alias Spike.ConnectionManager

  def handle_client_message(client_message) do
    client_message = Jason.decode!(client_message)
    Enum.each(client_message["targets"], fn target ->
      pid = ConnectionManager.get_connection(target)
      payload = Jason.encode!(client_message["payload"])
      Kernel.send(pid, {:text, payload})
    end)
  end
end
