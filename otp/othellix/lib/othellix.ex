defmodule Othellix do
  alias Othellix.{Game, HumanPlayer, AIPlayer, Notifier}

  def play(black_player \\ HumanPlayer, white_player \\ AIPlayer, notifier \\ Notifier.Verbose.new) do
    game = Game.new_game(black_player, white_player, notifier)
    Game.play_game(game)
  end

  def play_using_server(black_player \\ HumanPlayer, white_player \\ AIPlayer, notifier \\ Notifier.Proxy.new) do
    Othellix.Notifier.Server.start_link()
    cli_notifier = Notifier.Cli.new()
    verbose_notifier = Notifier.Verbose.new()

    Othellix.Notifier.Server.register_observer(cli_notifier)
    Othellix.Notifier.Server.register_observer(verbose_notifier)

    game = Game.new_game(black_player, white_player, notifier)
    Game.play_game(game)
  end
end
