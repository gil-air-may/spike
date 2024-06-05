defmodule Spike.WebsocketHandler do
  alias Spike.ConnectionManager
  def init(conn) do
    id = get_id_from_conn(conn)
    IO.puts('New connection PID: #{inspect(self())}, ID: #{id}')
    ConnectionManager.add_connection(id, self())
    {:ok, conn}
  end

  def handle_in({"ping", [opcode: :text]}, state) do
    {:reply, :ok, {:text, "pong"}, state}
  end

  def handle_in({something, [opcode: :text]}, state) do
    {:reply, :ok, {:text, something}, state}
  end


  def send_update(pid, type) do
    Kernel.send(pid, type)
  end

  def handle_info({:text, msg}, state) do
    {:push, {:text, "Echo: " <> msg}, state}
  end

  def handle_info({:close, _code, _reason}, state) do
    id = get_id_from_conn(state.conn)
    ConnectionManager.remove_connection(id)
    {:ok, state}
  end

  def handle_disconnect(_conn, state) do
    id = get_id_from_conn(state.conn)
    ConnectionManager.remove_connection(id)
    :ok
  end

  defp get_id_from_conn(conn) do
    conn.params["id"]
  end

  # def handle_info({:send_go}, state) do
  #   {:push, {:text, "go go go"}, state}
  # end

  # def handle_info({:send_hey}, state) do
  #   {:push, {:text, "hey hey hey"}, state}
  # end

  # def terminate(:timeout, state) do
  #   {:ok, state}
  # end
end
