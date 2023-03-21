defmodule PC.Driver do
  def produce_items(pid, n, delay \\ 500) do
    for _ <- 1..n do
      Process.sleep(delay + :rand.uniform(delay))
      PC.Producer.produce_item(pid)
    end
  end
end
