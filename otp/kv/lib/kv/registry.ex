defmodule KV.Registry do
  use GenServer

  # Client API

  @doc """
  Starts the registry.
  """
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @doc """
  Looks up the bucket pid for `name` stored in `server`.

  Returns `{:ok, pid}` if the bucket exists, `:error` otherwise.
  """
  def lookup(server, name) do
    GenServer.call(server, {:lookup, name})
  end

  def lookup(name) do
    lookup(__MODULE__, name)
  end

  @doc """
  Ensures there is a bucket associated to the given `name` in `server`.

  This version of the function uses a cast for pedagogical purposes.
  Don't do this for real!
  """
  def create_cast(server, name) do
    GenServer.cast(server, {:create, name})
  end

  @doc """
  Ensures there is a bucket associated to the given `name` in `server`.
  """
  def create(server, name) do
    GenServer.call(server, {:create, name})
  end

  def create(name) do
    create(__MODULE__, name)
  end

  # GenServer callbacks

  @impl true
  def init(:ok) do
    names = %{}
    refs = %{}
    {:ok, {names, refs}}
  end

  @impl true
  def handle_call({:lookup, name}, _from, state) do
    {names, _refs} = state
    {:reply, Map.fetch(names, name), state}
  end

  @impl true
  def handle_call({:create, name}, _from, {names, _refs} = state) do
    if Map.has_key?(names, name) do
      {:reply, {:ok, names[name]}, state}
    else
      {sup, state} = create_new_bucket(name, state)
      {:reply, {:ok, sup}, state}
    end
  end

  @impl true
  def handle_cast({:create, name}, {names, _refs} = state) do
    if Map.has_key?(names, name) do
      {:noreply, state}
    else
      {_, state} = create_new_bucket(name, state)
      {:noreply, state}
    end
  end

  @impl true
  def handle_info({:DOWN, ref, :process, _pid, _reason}, {names, refs}) do
    {name, refs} = Map.pop(refs, ref)
    names = Map.delete(names, name)
    {:noreply, {names, refs}}
  end

  @impl true
  def handle_info(msg, state) do
    require Logger
    Logger.debug("Unexpected message in KV registry: #{inspect(msg)}")
    {:noreply, state}
  end

  # Helpers
  def create_new_bucket(name, {names, refs}) do
    # We are both linking to and monitoring the bucket process. This is a very
    # bad idea! We are doing it here for pedagogical purposes. Don't do this for
    # real!
    {:ok, pid} = DynamicSupervisor.start_child(KV.BucketSupervisor, KV.Bucket)
    ref = Process.monitor(pid)
    refs = Map.put(refs, ref, name)
    names = Map.put(names, name, pid)
    {pid, {names, refs}}
  end
end
