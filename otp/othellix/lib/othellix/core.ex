defmodule Othellix.Core do
  @type position :: {integer, integer}
  @type move :: {integer, integer}
  @type color :: :black | :white
  @type board :: %{position => color}
  @type field :: :black | :white | :empty

  def other_color(:black), do: :white
  def other_color(:white), do: :black
end
