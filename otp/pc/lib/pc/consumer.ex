defmodule PC.Consumer do
  @spec consume_items(pid, non_neg_integer, non_neg_integer, {:ok, pid} | nil) :: :ok

  def consume_items(pid, n, delay \\ 500, store \\ nil)

  def consume_items(pid, n, delay, store) when n > 0 do
    consumed_item? = PC.Producer.get_item(pid) |> try_to_consume_next_item(store)
    Process.sleep(delay + :rand.uniform(100))
    n = if consumed_item?, do: n - 1, else: n
    consume_items(pid, n, delay, store)
  end

  def consume_items(_pid, _n, _delay, _store) do
    # IO.puts("#{inspect(self())}: Done consuming items.")
    :ok
  end

  @spec try_to_consume_next_item({:ok, non_neg_integer, pid} | :no_item, {:ok, pid} | nil) :: boolean

  defp try_to_consume_next_item({:ok, item, item_pid}, nil) do
    item_id = String.pad_leading(to_string(item), 2, " ")

    IO.puts(
      "#{inspect(self())}: " <>
        "Got item #{item_id} ordered by #{inspect(item_pid)}."
    )

    true
  end

  defp try_to_consume_next_item({:ok, item, item_pid}, {:ok, store_pid}) do
    PC.Store.add_item(store_pid, item, item_pid)
    true
  end

  defp try_to_consume_next_item(:no_item, _) do
    # IO.puts("#{inspect(self())}: No item available.")
    false
  end
end
