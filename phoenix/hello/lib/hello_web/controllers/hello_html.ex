defmodule HelloWeb.HelloHTML do
  use HelloWeb, :html

  embed_templates "hello_html/*"

  attr :messenger, :string, default: "world"

  def greet(assigns) do
    ~H"""
    <h1 class="text-[1.5rem] mt-4 font-semibold leading-10 tracking-tighter text-zinc-900">
    Hello world from <%= @messenger %>!
    </h1>
    """
  end
end
