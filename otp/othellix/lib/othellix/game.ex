defmodule Othellix.Game do
  alias Othellix.{Core, Player, HumanPlayer, AIPlayer, Notifier}

  defstruct board: %{}, players: [], notifier: nil

  @type t :: %Othellix.Game{
          board: Core.board(),
          players: [Player.t()],
          notifier: Othellix.Notifier.t()
        }

  def new_game(
        black_player \\ HumanPlayer,
        white_player \\ AIPlayer,
        notifier \\ nil
      ) do
    %Othellix.Game{
      board: new_board(),
      players: [black_player.new(:black), white_player.new(:white)],
      notifier: notifier
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

  def get_piece(board, {x, y}) do
    Map.get(board, {x, y}, :empty)
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

  defp adjacent_empty_positions(board, {x, y}) do
    all_neighbors({x, y})
    |> Enum.filter(&valid_empty_location?(&1, board))
  end

  defp valid_empty_location?({x, y}, board) do
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
    get_piece(board, {x, y}) == :empty
  end

  defp in_bounds?(x, y), do: x >= 0 and x <= 7 and y >= 0 and y <= 7

  defp is_valid_move?(board, {x, y}, color) do
    opponent_color = Core.other_color(color)

    Enum.any?(
      all_directions(),
      fn {dx, dy} ->
        {nx, ny} = {x + dx, y + dy}

        if in_bounds?(nx, ny) and get_piece(board, {nx, ny}) == opponent_color do
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
      case get_piece(board, {nx, ny}) do
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

    new_board =
      for {dx, dy} <- all_directions(), reduce: board do
        acc_board ->
          {nx, ny} = {x + dx, y + dy}

          if in_bounds?(nx, ny) and get_piece(board, {nx, ny}) == opponent_color do
            flip_pieces_in_direction(acc_board, x, y, dx, dy, color)
          else
            acc_board
          end
      end

    Map.put(new_board, {x, y}, color)
  end

  defp flip_pieces_in_direction(board, x, y, dx, dy, color) do
    case get_piece(board, {x, y}) do
      ^color ->
        board

      _ ->
        if in_bounds?(x, y) do
          flip_pieces_in_direction(set_piece(board, {x, y}, color), x + dx, y + dy, dx, dy, color)
        else
          board
        end
    end
  end

  def play_game(game) do
    game_loop(game, :black)
  end

  defp game_loop(game, current_color) do
    valid_moves = valid_moves(game.board, current_color)

    if Enum.empty?(valid_moves) do
      score = final_score(game.board)
      Notifier.note_result(game.notifier, game, current_color, score)
      score
    else
      player = Enum.find(game.players, fn p -> p.color == current_color end)
      {:ok, move} = Player.play_turn(player, game, valid_moves)
      updated_board = make_move(game.board, move, current_color)
      Notifier.note_move(game.notifier, game, current_color, move, updated_board)
      next_color = Core.other_color(current_color)
      game_loop(%{game | board: updated_board}, next_color)
    end
  end

  defp final_score(board) do
    Enum.reduce(board, %{black: 0, white: 0}, fn {_, color}, acc ->
      case color do
        :black -> Map.update!(acc, :black, &(&1 + 1))
        :white -> Map.update!(acc, :white, &(&1 + 1))
        _ -> acc
      end
    end)
  end
end
