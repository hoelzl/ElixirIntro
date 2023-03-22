defmodule PC.Producer do
  use GenServer

  # Public API

  def start_link(options \\ []) do
    GenServer.start_link(__MODULE__, {0, []}, options)
  end

  @spec stop(pid) :: :ok
  def stop(pid) do
    GenServer.stop(pid)
  end

  @spec produce_item(pid) :: :ok
  def produce_item(pid) do
    GenServer.call(pid, :produce_item)
  end

  @spec get_item(pid) :: {:ok, any, pid} | :no_item
  def get_item(pid) do
    GenServer.call(pid, :get_item)
  end

  # GenServer callbacks

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call(:produce_item, {pid, _}, {next, items}) do
    # IO.puts("Producing item #{next} for #{inspect(pid)}.")
    {:reply, :ok, {next + 1, [{next, pid} | items]}}
  end

  @impl true
  def handle_call(:get_item, _from, {next, [{item, pid} | rest]}) do
    {:reply, {:ok, item, pid}, {next, rest}}
  end

  @impl true
  def handle_call(:get_item, _from, {next, []}) do
    {:reply, :no_item, {next, []}}
  end
end
