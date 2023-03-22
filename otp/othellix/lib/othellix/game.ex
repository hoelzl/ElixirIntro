defmodule Othellix.Game do
  alias Othellix.{Core, Player, HumanPlayer, AIPlayer}

  defstruct board: %{}, players: []

  @type t :: %Othellix.Game{
          board: Core.board(),
          players: [Player.t()]
        }

  def new_game(black_player \\ HumanPlayer, white_player \\ AIPlayer) do
    %Othellix.Game{
      board: new_board(),
      players: [black_player.new(:black), white_player.new(:white)]
    }
  end

  def new_board do
    board = for x <- 0..7, y <- 0..7, into: %{}, do: {{x, y}, :empty}

    board
    |> Map.put({3, 3}, :white)
    |> Map.put({4, 4}, :white)
    |> Map.put({3, 4}, :black)
    |> Map.put({4, 3}, :black)
  end

  def set_piece(board, {x, y}, piece) do
    Map.put(board, {x, y}, piece)
  end

  def valid_moves(board, color) do
    opponent_color = if color == :black, do: :white, else: :black

    board
    |> Enum.filter(fn {_pos, p} -> p == opponent_color end)
    |> Enum.flat_map(fn {pos, _} -> adjacent_empty_positions(board, pos) end)
    |> Enum.uniq()
    |> Enum.filter(fn pos -> is_valid_move?(board, pos, color) end)
  end

  defp adjacent_empty_positions_old(board, x, y) do
    for {dx, dy} <- all_directions() do
      {nx, ny} = {x + dx, y + dy}

      if in_bounds?(nx, ny) and empty_location?(board, {nx, ny}) do
        {nx, ny}
      else
        nil
      end
    end
    |> Enum.reject(&is_nil/1)
  end

  defp adjacent_empty_positions(board, {x, y}) do
    result =
      all_neighbors({x, y})
      |> Enum.filter(&is_valid_empty_location(&1, board))
    if result != adjacent_empty_positions_old(board, x, y) do
      IO.puts("adjacent_empty_positions: #{inspect result}")
      IO.puts("adjacent_empty_positions_old: #{inspect adjacent_empty_positions_old(board, x, y)}")
    end
    result
  end

  defp is_valid_empty_location({x, y}, board) do
    in_bounds?(x, y) and empty_location?(board, {x, y})
  end

  defp all_neighbors({x, y}) do
    for {dx, dy} <- all_directions() do
      {x + dx, y + dy}
    end
  end

  defp all_directions do
    for dx <- -1..1, dy <- -1..1, dx != 0 or dy != 0 do
      {dx, dy}
    end
  end

  defp empty_location?(board, {x, y}) do
    Map.get(board, {x, y}) == :empty
  end

  defp in_bounds?(x, y), do: x >= 0 and x <= 7 and y >= 0 and y <= 7

  defp is_valid_move?(board, {x, y}, color) do
    opponent_color = if color == :black, do: :white, else: :black

    Enum.any?(
      all_directions(),
      fn {dx, dy} ->
        {nx, ny} = {x + dx, y + dy}

        if in_bounds?(nx, ny) and Map.get(board, {nx, ny}) == opponent_color do
          count = count_pieces_in_direction(board, x, y, dx, dy, color, 0)
          count > 0
        else
          false
        end
      end
    )
  end

  defp count_pieces_in_direction(board, x, y, dx, dy, color, count) do
    {nx, ny} = {x + dx, y + dy}

    if in_bounds?(nx, ny) do
      case Map.get(board, {nx, ny}) do
        :empty -> 0
        ^color -> count
        _ -> count_pieces_in_direction(board, nx, ny, dx, dy, color, count + 1)
      end
    else
      0
    end
  end

  def make_move(board, {x, y}, color) do
    opponent_color = if color == :black, do: :white, else: :black

    directions_to_flip =
      for(
        dx <- -1..1,
        dy <- -1..1,
        dx != 0 or dy != 0,
        do: {dx, dy}
      )
      |> Enum.filter(fn {dx, dy} ->
        {nx, ny} = {x + dx, y + dy}

        if in_bounds?(nx, ny) and Map.get(board, {nx, ny}) == opponent_color do
          count_pieces_in_direction(board, nx, ny, dx, dy, color, 0) > 0
        else
          false
        end
      end)

    Enum.reduce(directions_to_flip, set_piece(board, {x, y}, color), fn {dx, dy}, updated_board ->
      flip_pieces_in_direction(updated_board, x + dx, y + dy, dx, dy, color)
    end)
  end

  defp flip_pieces_in_direction(board, x, y, dx, dy, color) do
    case Map.get(board, {x, y}) do
      ^color ->
        board

      _ ->
        flip_pieces_in_direction(set_piece(board, {x, y}, color), x + dx, y + dy, dx, dy, color)
    end
  end

  def play_game(game) do
    game_loop(game, :black)
  end

  defp game_loop(game, current_color) do
    IO.puts("Current board:")
    print_board(game.board)

    valid_moves = valid_moves(game.board, current_color)
    IO.inspect(valid_moves, label: "Valid moves for #{current_color}")

    if Enum.empty?(valid_moves) do
      IO.puts("No valid moves for #{current_color}, game over!")
      final_score(game.board)
    else
      player = Enum.find(game.players, fn p -> p.color == current_color end)
      {:ok, move} = Player.play_turn(player, game.board, valid_moves)

      updated_board = make_move(game.board, move, current_color)
      next_color = if current_color == :black, do: :white, else: :black

      game_loop(%{game | board: updated_board}, next_color)
    end
  end

  defp as_board_field(piece) do
    case piece do
      :black -> "B"
      :white -> "W"
      _ -> "."
    end
  end

  defp print_board(board) do
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

  defp final_score(board) do
    scores =
      Enum.reduce(board, %{black: 0, white: 0}, fn {_, color}, acc ->
        case color do
          :black -> Map.update!(acc, :black, &(&1 + 1))
          :white -> Map.update!(acc, :white, &(&1 + 1))
          _ -> acc
        end
      end)

    IO.inspect(scores, label: "Final score")
  end
end
