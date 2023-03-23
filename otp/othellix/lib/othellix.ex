defmodule Othellix do
  alias Othellix.{Game, HumanPlayer, AIPlayer, Notifier}

  def play(black_player \\ HumanPlayer, white_player \\ AIPlayer, notifier \\ Notifier.Verbose.new) do
    game = Game.new_game(black_player, white_player, notifier)
    Game.play_game(game)
  end
end
