defmodule Othellix do
  alias Othellix.{Game, HumanPlayer, AIPlayer}

  def play(black_player \\ HumanPlayer, white_player \\ AIPlayer) do
    game = Game.new_game(black_player, white_player)
    Game.play_game(game)
  end
end
