defmodule Spike.WebsocketHandler do
  def init(options) do
    IO.inspect(options)
    {:ok, options}
  end


  def handle_in({"ping", [opcode: :text]}, state) do
    {:reply, :ok, {:text, "pong"}, state}
  end

  def send_update(pid, type) do
    Kernel.send(pid, type)
  end

  def handle_info({:send_go}, state) do
    {:push, {:text, "go go go"}, state}
  end

  def handle_info({:send_hey}, state) do
    {:push, {:text, "hey hey hey"}, state}
  end

  def terminate(:timeout, state) do
    {:ok, state}
  end
end
