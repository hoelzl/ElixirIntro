defmodule PC.Driver do
  @spec produce_items(pid, non_neg_integer, non_neg_integer) :: [any]

  def produce_items(pid, n, delay \\ 500) when n >= 0 do
    for _ <- 1..n do
      Process.sleep(delay + :rand.uniform(100))
      PC.Producer.produce_item(pid)
    end
  end
end
