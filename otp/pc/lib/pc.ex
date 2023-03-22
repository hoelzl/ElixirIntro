defmodule PC do
  @moduledoc """
  A simple producer/consumer example.
  """
  @spec run_sequentially() :: :ok

  @doc "Runs the producer/consumer example sequentially."
  def run_sequentially do
    {:ok, producer} = PC.Producer.start_link()

    PC.Driver.produce_items(producer, 10, 200)
    PC.Consumer.consume_items(producer, 10)
  end

  @default_opts [
    num_drivers: 2,
    num_consumers: 4,
    num_items: 16,
    driver_delay: 200,
    consumer_delay: 400,
    observer_delay: 500,
    use_store: false
  ]

  @spec run_concurrently(Keyword.t()) :: any

  @doc """
  Runs the producer/consumer example concurrently but without supervision.
  """
  def run_concurrently(opts \\ []) do
    opts = Keyword.merge(@default_opts, opts)

    {:ok, producer} = PC.Producer.start_link()

    spawn_drivers(producer, opts)
    spawn_consumers(producer, opts)
  end

  defp spawn_drivers(producer, opts) do
    num_items = div(opts[:num_items], opts[:num_drivers])

    for _ <- 1..opts[:num_drivers] do
      spawn(fn ->
        PC.Driver.produce_items(producer, num_items, opts[:driver_delay])
        Process.link(producer)
      end)
    end
  end

  defp spawn_consumers(producer, opts) do
    num_items = div(opts[:num_items], opts[:num_consumers])
    store = if opts[:use_store], do: PC.Store.start_link([]), else: nil

    for _ <- 1..opts[:num_consumers] do
      spawn(fn ->
        PC.Consumer.consume_items(producer, num_items, opts[:consumer_delay], store)
      end)
    end

    store
  end

  @doc """
  Runs the producer/consumer example concurrently using tasks.
  """
  def run_with_tasks(opts \\ []) do
    opts = Keyword.merge(@default_opts, opts)

    {:ok, producer} = PC.Producer.start_link()

    create_driver_tasks(producer, opts)
    create_consumer_tasks(producer, opts)
  end

  def create_driver_tasks(producer, opts) do
    num_items = div(opts[:num_items], opts[:num_drivers])

    for _ <- 1..opts[:num_drivers] do
      Task.start_link(fn ->
        PC.Driver.produce_items(producer, num_items, opts[:driver_delay])
      end)
    end
  end

  def create_consumer_tasks(producer, opts) do
    num_items = div(opts[:num_items], opts[:num_consumers])
    store = if opts[:use_store], do: PC.Store.start_link([]), else: nil

    for _ <- 1..opts[:num_consumers] do
      Task.start_link(fn ->
        PC.Consumer.consume_items(producer, num_items, opts[:consumer_delay], store)
      end)
    end

    store
  end

  def set_all(n \\ 1000, num_items \\ nil, delay \\ nil) do
    num_items = num_items || n

    default_opts =
      if delay do
        Keyword.merge(@default_opts, driver_delay: delay, consumer_delay: delay)
      else
        @default_opts
      end

    Keyword.merge(default_opts,
      use_store: true,
      num_drivers: n,
      num_consumers: n,
      num_items: num_items
    )
  end

  def run_observed(opts \\ []) do
    opts = Keyword.merge(@default_opts, opts)
    opts = Keyword.merge(opts, use_store: true)
    {:ok, store} = run_with_tasks(opts)
    start_observer(store, opts)
  end

  def start_observer(store, opts) do
    spawn(fn -> observer_loop(opts[:num_items], store, opts[:observer_delay]) end)
  end

  def observer_loop(num_expected, store, delay) do
    actual = length(PC.Store.get_items(store))
    IO.puts("Items in store: #{actual}")

    if actual < num_expected do
      Process.sleep(delay)
      observer_loop(num_expected, store, delay)
    end
  end
end
