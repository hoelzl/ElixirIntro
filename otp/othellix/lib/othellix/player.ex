defprotocol Othellix.Player do
  alias Othellix.{Player, Core}

  @spec play_turn(Player, Core.board(), Core.color()) ::
          {:ok, Othellix.t()} | {:error, String.t()}
  def play_turn(player, board, color)
end

defmodule Othellix.HumanPlayer do
  defstruct color: nil

  def new(color) do
    %__MODULE__{color: color}
  end
end

defimpl Othellix.Player, for: Othellix.HumanPlayer do
  def play_turn(_player, _board, valid_moves) do
    # Prompt the human player for input and make the move
    # Note: Add error handling and input validation
    IO.puts("Your valid moves are: #{inspect valid_moves}.")
    IO.puts("Enter the row and column (0-7) separated by a comma:")
    input = IO.gets("") |> String.trim() |> String.split(",", trim: true)
    {row, col} = {String.to_integer(Enum.at(input, 0)), String.to_integer(Enum.at(input, 1))}

    {:ok, {row, col}}
  end
end

defmodule Othellix.AIPlayer do
  defstruct color: nil

  def new(color) do
    %__MODULE__{color: color}
  end
end

defimpl Othellix.Player, for: Othellix.AIPlayer do
  alias Othellix.Game

  def play_turn(_player, _board, valid_moves) do
    case valid_moves do
      [] ->
        {:error, "No valid moves"}

      moves ->
        # Pick a random move
        move = Enum.random(moves)
        IO.puts("AI player chose move: #{inspect move}")
        {:ok, move}
    end
  end
end
