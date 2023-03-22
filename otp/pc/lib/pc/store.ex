defmodule PC.Store do
  use GenServer

  @doc """
  Starts a new store.
  """
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [])
  end

  @doc """
  Adds an item to the store.
  """
  def add_item(store, item, item_pid) do
    GenServer.call(store, {:add_item, item, item_pid})
  end

  @doc """
  Gets all items from the store.
  """
  def get_items(store) do
    GenServer.call(store, :get_items)
  end

  # GenServer callbacks
  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call({:add_item, item, item_pid}, _from, state) do
    # IO.puts("Adding item #{inspect(item)} to store.")
    {:reply, :ok, [{item, item_pid} | state]}
  end

  @impl true
  def handle_call(:get_items, _from, state) do
    {:reply, state, state}
  end
end
