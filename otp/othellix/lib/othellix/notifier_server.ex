defmodule Othellix.Notifier.Server do
  use GenServer
  require Logger
  alias Othellix.Notifier

  def start_link(opts \\ []) do
    opts = Keyword.put_new(opts, :name, __MODULE__)
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def register_observer(observer) do
    GenServer.cast(__MODULE__, {:register_observer, observer})
  end

  def notify(_notifier, message) do
    GenServer.cast(__MODULE__, {:notify, message})
  end

  def note_new_game(_notifier, game) do
    GenServer.cast(__MODULE__, {:note_new_game, game})
  end

  def note_move(_notifier, old_game, color, move, new_board) do
    GenServer.cast(__MODULE__, {:note_move, old_game, color, move, new_board})
  end

  def note_result(_notifier, game, current_color, score) do
    GenServer.cast(__MODULE__, {:note_result, game, current_color, score})
  end

  def init(:ok) do
    {:ok, []}
  end

  def handle_cast({:register_observer, observer}, observers) do
    Logger.debug("Notifier.Server: {:register_observer #{inspect(observer)}}")
    {:noreply, [observer | observers]}
  end

  def handle_cast({:notify, message}, observers) do
    Logger.debug("Notifier.Server: {:notify #{message}}")

    for observer <- observers do
      Logger.debug("Notifier.Server: calling notify(\"#{message}\") on #{inspect(observer)}")
      Notifier.notify(observer, message)
    end

    {:noreply, observers}
  end

  def handle_cast({:note_new_game, game}, observers) do
    Logger.debug("Notifier.Server: {:note_new_game #{game}}")

    for observer <- observers do
      Logger.debug("Notifier.Server: calling note_new_game() on #{inspect(observer)}")
      Notifier.note_new_game(observer, game)
    end

    {:noreply, observers}
  end

  def handle_cast({:note_move, old_game, color, move, new_board}, observers) do
    Logger.debug("Notifier.Server: {:note_move ...}")

    for observer <- observers do
      Logger.debug(
        "Notifier.Server: calling note_move() on #{inspect(observer)}"
      )

      Notifier.note_move(observer, old_game, color, move, new_board)
    end

    {:noreply, observers}
  end

  def handle_cast({:note_result, game, current_color, score}, observers) do
    Logger.debug("Notifier.Server: {:note_result ...}")

    for observer <- observers do
      Logger.debug(
        "Notifier.Server: calling note_result() on #{inspect(observer)}"
      )

      Notifier.note_result(observer, game, current_color, score)
    end

    {:noreply, observers}
  end
end

defmodule Othellix.Notifier.Proxy do
  defstruct []

  def new do
    %__MODULE__{}
  end
end

defimpl Othellix.Notifier, for: Othellix.Notifier.Proxy do
  defdelegate notify(notifier, message), to: Othellix.Notifier.Server
  defdelegate note_new_game(notifier, game), to: Othellix.Notifier.Server
  defdelegate note_move(notifier, old_game, color, move, new_board), to: Othellix.Notifier.Server
  defdelegate note_result(notifier, game, current_color, score), to: Othellix.Notifier.Server
end
