defprotocol Othellix.Notifier do
  @doc """
  Send a generic message to the notifier.
  """
  def notify(notifier, message)

  @doc """
  Send a message that a new game has started.
  """
  def note_new_game(notifier, game)

  @doc """
  Send a message that a move has occurred.
  """
  def note_move(notifier, old_game, color, move, new_board)

  @doc """
  Send a message that a game has ended.
  """
  def note_result(notifier, game, current_color, score)
end

defimpl Othellix.Notifier, for: Atom do
  @impl true
  def notify(_notifier, _message), do: :ok

  @impl true
  def note_new_game(_notifier, _game), do: :ok

  @impl true
  def note_move(_notifier, _old_game, _color, _move, _new_board), do: :ok

  @impl true
  def note_result(_notifier, _game, _current_color, _score), do: :ok
end

defmodule Othellix.Notifier.Utils do
  def as_board_field(piece) do
    case piece do
      :black -> "B"
      :white -> "W"
      _ -> "."
    end
  end

  def print_board(board) do
    IO.puts("  0 1 2 3 4 5 6 7")

    for y <- 0..7 do
      row = Enum.map(0..7, &Map.get(board, {&1, y}, :empty))

      IO.puts(
        "#{y} #{Enum.map_join(row, " ", fn
          :empty -> "."
          piece -> as_board_field(piece)
        end)}"
      )
    end
  end
end

defmodule Othellix.Notifier.Cli do
  defstruct []

  def new do
    %Othellix.Notifier.Cli{}
  end
end

defimpl Othellix.Notifier, for: Othellix.Notifier.Cli do
  import Othellix.Notifier.Utils

  @impl true
  def notify(_notifier, message) do
    IO.puts(message)
  end

  @impl true
  def note_new_game(_notifier, game) do
    IO.puts("New game started!")
    print_board(game.board)
  end

  @impl true
  def note_move(_notifier, _old_game, color, {x, y}, _new_board) do
    IO.puts("Player #{color} plays move (#{x}, #{y}).")
  end

  @impl true
  def note_result(_notifier, game, current_color, score) do
    IO.puts("No valid moves for #{current_color}!")
    IO.puts("Game over! Score: #{inspect score}")
    print_board(game.board)
  end
end

defmodule Othellix.Notifier.Verbose do
  defstruct []

  def new do
    %Othellix.Notifier.Verbose{}
  end
end

defimpl Othellix.Notifier, for: Othellix.Notifier.Verbose do
  import Othellix.Notifier.Utils

  @impl true
  def notify(_notifier, message) do
    IO.puts(message)
  end

  @impl true
  def note_new_game(_notifier, game) do
    IO.puts("New game started!")
    print_board(game.board)
  end

  @impl true
  def note_move(_notifier, _old_game, color, {x, y}, new_board) do
    IO.puts("Player #{color} plays move (#{x}, #{y}).")
    print_board(new_board)
  end

  @impl true
  def note_result(_notifier, game, current_color, score) do
    IO.puts("No valid moves for #{current_color}!")
    IO.puts("Game over! Score: #{inspect score}")
    print_board(game.board)
  end
end
