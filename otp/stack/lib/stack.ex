defmodule Stack do
  @moduledoc """
  A simple stack implementation using OTP.
  """
  use GenServer

  # Public API

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [], opts)
  end

  def stop(pid) do
    GenServer.stop(pid)
  end

  def size(pid) do
    GenServer.call(pid, :size)
  end

  def push(pid, item) do
    GenServer.call(pid, {:push, item})
  end

  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  # GenServer callbacks

  def init(_) do
    {:ok, []}
  end

  def handle_call(:size, _from, state) do
    {:reply, length(state), state}
  end

  def handle_call({:push, item}, _from, state) do
    {:reply, :ok, [item | state]}
  end

  def handle_call(:pop, _from, [item | rest]) do
    {:reply, {:ok, item}, rest}
  end

  def handle_call(:pop, _from, []) do
    {:reply, :empty, []}
  end
end
