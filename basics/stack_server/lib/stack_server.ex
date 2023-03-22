defmodule StackServer do
  # Client API (implement later, except for `start/0`)
  def start_link do
    {:ok, spawn_link(__MODULE__, :loop, [[]])}
  end

  def push(stack, item) do
    send(stack, {:push, item})
  end

  def pop(stack) do
    send(stack, {:pop, self()})
    receive do
      {:ok, item} -> item
      :empty -> :empty
    end
  end

  def top(stack) do
    send(stack, {:top, self()})
    receive do
      {:ok, item} -> item
      :empty -> :empty
    end
  end

  def size(stack) do
    send(stack, {:size, self()})
    receive do
      {:ok, size} -> size
    end
  end

  def empty?(stack) do
    send(stack, {:empty?, self()})
    receive do
      {:ok, empty} -> empty
    end
  end

  def clear(stack) do
    send(stack, {:clear})
  end

  def as_list(stack) do
    send(stack, {:as_list, self()})
    receive do
      {:ok, list} -> list
    end
  end

  def stop(stack) do
    send(stack, {:stop, self()})
    receive do
      _ -> :ok
    end
  end

  # Implementation
  def loop(stack) do
    receive do
      {:push, item} ->
        loop([item | stack])

      {:pop, pid} ->
        case stack do
          [] ->
            send(pid, :empty)
            loop([])

          [item | rest] ->
            send(pid, {:ok, item})
            loop(rest)
        end

      {:top, pid} ->
        case stack do
          [] ->
            send(pid, :empty)
            loop([])

          [item | _] ->
            send(pid, {:ok, item})
            loop(stack)
        end

      {:size, pid} ->
        send(pid, {:ok, length(stack)})
        loop(stack)

      {:empty?, pid} ->
        send(pid, {:ok, stack == []})
        loop(stack)

      {:clear} ->
        loop([])

      {:as_list, pid} ->
        send(pid, {:ok, stack})
        loop(stack)

      {:stop, pid} ->
        send(pid, :ok)
        :ok
    end
  end
end
