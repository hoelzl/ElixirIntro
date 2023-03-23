defprotocol Othellix.Player do
  alias Othellix.{Player, Core, Game}

  @spec play_turn(Player, Game.t(), Core.color()) ::
          {:ok, Othellix.t()} | {:error, String.t()}
  def play_turn(player, game, color)
end

defmodule Othellix.HumanPlayer do
  defstruct color: nil

  def new(color) do
    %__MODULE__{color: color}
  end
end

defimpl Othellix.Player, for: Othellix.HumanPlayer do
  @impl true
  def play_turn(_player, game, valid_moves) do
    import Othellix.Notifier.Utils

    IO.puts("Current board:")
    print_board(game.board)

    IO.puts("Your valid moves are:")
    valid_moves |> Enum.with_index() |> Enum.each(fn {{x, y}, index} ->
      IO.puts("#{index + 1}: #{x}, #{y}")
    end)
    input = IO.gets("Pick a move: ") |> String.trim() |> String.to_integer()

    {:ok, Enum.at(valid_moves, input - 1)}
  end
end

defmodule Othellix.AIPlayer do
  defstruct color: nil

  def new(color) do
    %__MODULE__{color: color}
  end
end

defimpl Othellix.Player, for: Othellix.AIPlayer do
  @impl true
  def play_turn(_player, _game, valid_moves) do
    case valid_moves do
      [] ->
        {:error, "No valid moves"}

      moves ->
        # Pick a random move
        move = Enum.random(moves)
        {:ok, move}
    end
  end
end
