defmodule Spike.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "world")
  end

  get "/websocket/:id" do
    conn
    |> WebSockAdapter.upgrade(Spike.WebsocketHandler, conn, timeout: 600_000)
    |> halt()
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
