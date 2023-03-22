defmodule Othellix do
  alias Othellix.Game

  def play() do
    game = Game.new_game()
    Game.play_game(game)
  end
end
