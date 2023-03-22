defmodule Othellix.Core do
  @type position :: {integer, integer}
  @type color :: :black | :white
  @type board :: %{position => color}
  @type field :: :black | :white | :empty
end
