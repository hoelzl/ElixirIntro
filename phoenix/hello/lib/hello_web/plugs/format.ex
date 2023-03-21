defmodule HelloWeb.Plugs.Format do
  import Plug.Conn

  def init(default) do
    default
  end

  def call(%Plug.Conn{params: %{"format" => format}} = conn, _default) do
    conn
    |> assign(:format, format)
  end

  def call(conn, default) do
    conn
    |> assign(:format, default)
  end
end
