defmodule PC.Producer do
  use GenServer

  # Public API

  def start_link do
    GenServer.start_link(__MODULE__, :ok)
  end

  def stop(pid) do
    GenServer.stop(pid)
  end

  def produce_item(pid) do
    GenServer.call(pid, :produce_item)
  end

  def get_item(pid) do
    GenServer.call(pid, :get_item)
  end

  # GenServer callbacks

  def init(:ok) do
    {:ok, []}
  end

  def handle_call(:produce_item, {pid, _}, state) do
    IO.puts("Producing item for #{inspect(pid)}.")
    item = :rand.uniform(100)
    {:reply, :ok, [{item, pid} | state]}
  end

  def handle_call(:get_item, _from, [{item, pid} | rest]) do
    {:reply, {:ok, item, pid}, rest}
  end

  def handle_call(:get_item, _from, []) do
    {:reply, :no_item, []}
  end
end
