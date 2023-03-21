defmodule PC.Consumer do
  def consume_items(pid, n, delay \\ 500)

  def consume_items(pid, n, delay) when n > 0 do
    consumed_item? = try_to_consume_next_item(PC.Producer.get_item(pid))
    Process.sleep(delay + :rand.uniform(delay))
    n = if consumed_item?, do: n - 1, else: n
    consume_items(pid, n, delay)
  end

  def consume_items(_pid, _n, _delay) do
    IO.puts("#{inspect(self())}: Done consuming items.")
  end

  def try_to_consume_next_item({:ok, item, item_pid}) do
    item_id = String.pad_leading(to_string(item), 2, " ")

    IO.puts(
      "#{inspect(self())}: " <>
        "Got item #{item_id} ordered by #{inspect(item_pid)}."
    )

    true
  end

  def try_to_consume_next_item(:no_item) do
    IO.puts("#{inspect(self())}: No item available.")
    false
  end
end
