defmodule HelloWeb.HelloController do
  use HelloWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end

  def show(conn, %{"messenger" => messenger}) do
    conn
    |> put_layout(html: :admin)
    |> render(:show, messenger: messenger)
  end

  def show_many_values(conn, %{"messenger" => messenger, "format" => format}) do
    conn
    |> assign(:messenger, messenger)
    |> assign(:format, format)
    |> assign(:values, [1, 2, 3, 4, 5])
    |> render(:show_many_values)
  end

  def show_many_values(conn, %{"messenger" => messenger}) do
    conn
    |> assign(:messenger, messenger)
    |> assign(:format, "No format provided?")
    |> assign(:values, inspect([1, 2, 3, 4, 5]))
    |> render(:show_many_values)
  end

  def show_text(conn, %{"messenger" => messenger}) do
    text(conn, "Hello #{messenger}!")
  end

  def show_json(conn, %{"messenger" => messenger}) do
    json(conn, %{message: "Hello #{messenger}!"})
  end

  def show_multi(conn, %{"messenger" => messenger, "format" => "json"}) do
    json(conn, %{message: "Hello #{messenger}!"})
  end

  def show_multi(conn, %{"messenger" => messenger, "format" => "text"}) do
    text(conn, "Hello #{messenger}!")
  end

  def show_multi(conn, %{"messenger" => messenger, "format" => "inline-html"}) do
    html(
      conn,
      """
      <h1>Hello #{messenger}!</h1>
      <p>How are you?</p>
      """
    )
  end

  def show_multi(conn, %{"messenger" => messenger}) do
    render(conn, :show, messenger: messenger)
  end

  def redirect_test(conn, _params) do
    redirect(conn, to: ~p"/multi/Redirector")
  end

  def external_redirect(conn, _params) do
    redirect(conn, external: "https://elixir-lang.org/")
  end

  def flash(conn, %{"flash" => "info"}) do
    conn
    |> put_flash(:info, "This is an info message")
    |> render(:show, messenger: "Info Flasher")
  end

  def flash(conn, %{"flash" => "error"}) do
    conn
    |> put_flash(:error, "This is an error message")
    |> render(:show, messenger: "Error Flasher")
  end

  def flash(conn, _params) do
    conn
    |> put_flash(:info, "This is an info message")
    |> render(:show, messenger: "Default Flasher")
  end
end
