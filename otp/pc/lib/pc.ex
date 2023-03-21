defmodule PC do
  @moduledoc """
  A simple producer/consumer example.
  """

  def run_sequentially do
    {:ok, producer} = PC.Producer.start_link()

    PC.Driver.produce_items(producer, 10, 100)
    PC.Consumer.consume_items(producer, 10)
  end

  @default_opts [
    num_drivers: 2,
    num_consumers: 4,
    num_items: 16,
    driver_delay: 200,
    consumer_delay: 300
  ]

  def run_without_supervision(opts \\ []) do
    opts = Keyword.merge(@default_opts, opts)

    {:ok, producer} = PC.Producer.start_link()
    num_items_per_driver = div(opts[:num_items], opts[:num_drivers])
    num_items_per_consumer = div(opts[:num_items], opts[:num_consumers])

    spawn_drivers(producer, opts[:num_drivers], num_items_per_driver, opts[:driver_delay])
    spawn_consumers(producer, opts[:num_consumers], num_items_per_consumer, opts[:consumer_delay])
  end

  defp spawn_drivers(producer, num_drivers, num_items, delay) do
    for _ <- 1..num_drivers do
      spawn(fn ->
        PC.Driver.produce_items(producer, num_items, delay)
      end)
    end
  end

  defp spawn_consumers(producer, num_consumers, num_items, delay) do
    for _ <- 1..num_consumers do
      spawn(fn ->
        PC.Consumer.consume_items(producer, num_items, delay)
      end)
    end
  end
end
