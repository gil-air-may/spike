defmodule Spike.ConnectionManager do
  use GenServer

  # Client API
  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def add_connection(id, pid) do
    GenServer.call(__MODULE__, {:add_connection, id, pid})
  end

  def remove_connection(id) do
    GenServer.call(__MODULE__, {:remove_connection, id})
  end

  def get_connection(id) do
    GenServer.call(__MODULE__, {:get_connection, id})
  end

  def get_conn_map do
    GenServer.call(__MODULE__, :get_conn_map)
  end

  # Server Callbacks
  def init(state) do
    {:ok, state}
  end

  def handle_call({:add_connection, id, pid}, _from, state) do
    {:reply, :ok, Map.put(state, id, pid)}
  end

  def handle_call({:remove_connection, id}, _from, state) do
    {:reply, :ok, Map.delete(state, id)}
  end

  def handle_call({:get_connection, id}, _from, state) do
    {:reply, Map.get(state, id), state}
  end

  def handle_call(:get_conn_map, _from, state) do
    {:reply, state, state}
  end
end
