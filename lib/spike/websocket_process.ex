defmodule Spike.WebsocketProcess do
  alias Spike.ConnectionManager
  alias Spike.Message
  def init(conn) do
    id = get_id_from_conn(conn)
    IO.puts('New connection PID: #{inspect(self())}, ID: #{id}')
    ConnectionManager.add_connection(id, self())
    {:ok, conn}
  end

  def handle_in({client_message, [opcode: :text]}, state) do
    Message.handle_client_message(client_message)
    {:ok, state}
  end

  def handle_info({:text, server_message}, state) do
    {:push, {:text, server_message}, state}
  end

  def handle_info({:close, _code, _reason}, state) do
    id = get_id_from_conn(state.conn)
    ConnectionManager.remove_connection(id)
    {:ok, state}
  end

  defp get_id_from_conn(conn) do
    String.to_integer(conn.params["id"])
  end
end
