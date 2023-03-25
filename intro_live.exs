1
0x1F
123_456_789_123_456_789_123_456_789_123_456_789_123_456_789_123_456_789_123_456_789

0.1 * 1.1
1.0e-10

:atom == :atom
Modul == :"Elixir.Modul"
:atom_with_underscore

"Hello, world!"
'Hello, world!'

{1, 2, 3}
{1}
{1, 2, 3} == {2, 3, 1}
{1, :atom, "Hallo!"}

[1, 2, 3]
[1 | [2]]
[1 | [2]] == [1, 2]
[]
[1, 2, 3] == [1 | [2 | [3 | []]]]

%{a: 1, b: 2}
%{:a => 1, :b => 2}
%{"a" => 1, "b" => 2}

:a == "a"

<<1, 2, 3>>
<<1::size(2), 0::size(1)>>

~r/regex/
~r/regex/i

"regex" =~ ~r/regex/
"Regex" =~ ~r/regex/
"Regex" =~ ~r/regex/i
"aaabbbaaa" =~ ~r/a+b{3}a*/
"abbb" =~ ~r/a+b{3}a*/
"abba" =~ ~r/a+b{3}a*/

1 + 2
1 / 2
div(5, 2)
rem(5, 2)

1 < 2

true and false
true or false
not true

1 and 2

1 && 2
1 || 2

false
nil

1 || 2
nil || 2

defmodule MyModule do
  def my_function do
    1 + 2
  end

  def your_function(x, y) do
    x + y
  end

  def your_function(x, y, z) do
    x + y + z
  end

  def not_so_secret do
    secret()
  end

  defp secret do
    "My secret"
  end
end

MyModule.my_function()
MyModule.my_function()

MyModule.your_function(1, 2)
MyModule.your_function(1, 2)

MyModule.your_function(1, 2, 3)

MyModule.not_so_secret()

defmodule MyModule do
  def my_function(1, 2) do
    "Matched!"
  end

  def my_function(x, y) when x > 0 and y > 0 do
    "Matched for positive values!"
  end

  def my_function(_x, _y) do
    "Not matched!"
  end
end

MyModule.my_function(1, 2)
MyModule.my_function(1, 3)
MyModule.my_function(-1, 3)

defmodule MyModule do
  def my_function([head | tail]) do
    IO.puts("Matched: #{inspect(head)}, #{inspect(tail)}")
  end

  def my_function([]) do
    IO.puts("Matched: []")
  end
end

MyModule.my_function([1, 2, 3])
MyModule.my_function([1])
MyModule.my_function([])

defmodule Fact do
  def fact(0) do
    1
  end

  def fact(n) do
    n * fact(n - 1)
  end
end

Fact.fact(5)
Fact.fact(0)

import Fact

fact(3) == 3 * 2 * 1
fact(3) == 3 * fact(2)

fact(4) == 4 * 3 * 2 * 1
fact(4) == 4 * fact(3)
fact(4) == 4 * 3 * fact(2)
fact(4) == 4 * 3 * 2 * fact(1)
fact(4) == 4 * 3 * 2 * 1

defmodule Sum do
  def sum([]) do
    0
  end

  def sum([head]) do
    head
  end

  def sum([head | tail]) do
    head + sum(tail)
  end
end

Sum.sum([1, 2, 3, 4, 5])
Sum.sum([])
Sum.sum([10])

defmodule MyModule do
  def my_function({:ok, result}) do
    IO.puts("Result: #{result}")
  end

  def my_function({:error, reason}) do
    IO.puts("Error: #{reason}")
  end
end

MyModule.my_function({:ok, 1})
MyModule.my_function({:error, "Something went wrong"})
MyModule.my_function({:ok, 1, 2})

defmodule MyModule do
  def my_function(%{key: value}) do
    IO.puts("Matched: #{value}")
  end

  def my_function(_) do
    IO.puts("Not matched")
  end
end

MyModule.my_function(%{key: 1})
MyModule.my_function(%{key: 1, key2: 2})
MyModule.my_function(%{key2: 2})

defmodule MyModule do
  def return_tuple(0) do
    {:error, "Something went wrong"}
  end

  def return_tuple(n) do
    {:ok, n}
  end

  def my_function(n) do
    case return_tuple(n) do
      {:ok, result} ->
        IO.puts("Result: #{result}")
        result

      {:error, reason} ->
        IO.puts("Error: #{reason}")
        :error
    end
  end
end

MyModule.my_function(1)
MyModule.my_function(0)

IO.puts("Hello, world!")

defmodule MyModule do
  @moduledoc """
  This is my module.
  """

  @my_value 1
  @doc "This is my function."
  def my_function do
    @my_value
  end

  @my_value 2
  @doc "This is your function."
  def your_function do
    @my_value
  end
end

MyModule.my_function()
MyModule.your_function()

my_fun = fn x -> x + 1 end
my_fun.(1)

your_fun = fn -> "Hello, world!" end
your_fun
your_fun.()

module_fun = &MyModule.my_function/0
module_fun
module_fun.()

defmodule MyModule do
  def my_function(x) do
    if x == 2 do
      IO.puts("Really matched 2!")
      "Matched 2!"
    else
      "Not matched"
    end
  end
end

MyModule.my_function(1)
MyModule.my_function(2)

defmodule MyModule do
  def my_function(x) do
    case x do
      1 ->
        "Matched 1!"

      2 ->
        "Matched 2!"

      _ ->
        "Not matched"
    end
  end
end

MyModule.my_function(1)
MyModule.my_function(2)
MyModule.my_function(3)

defmodule MyModule do
  def my_for_loop() do
    for i <- 1..3, j <- 2..4, reduce: 0 do
      acc -> IO.puts("i: #{i}, j: #{j}")
    end
  end
end

MyModule.my_for_loop()

defmodule MyModule do
  def my_function do
    raise "Something went wrong"
  end

  def your_function do
    try do
      my_function()
    rescue
      RuntimeError -> "Something went wrong"
    after
      IO.puts("This is always executed")
    end
  end

  def his_function do
    my_function()
  rescue
    RuntimeError -> "Something went wrong"
  after
    IO.puts("This is always executed")
  end
end

MyModule.my_function()
MyModule.your_function()
MyModule.his_function()

[1, 2, 3]
[1 | [2, 3]]

[1, 2, 3] ++ [4, 5, 6]
[1, 2, 3, 3, 2] -- [2, 3]

List.first([1, 2, 3])
List.last([1, 2, 3])
List.delete_at([1, 2, 3], 1)
List.delete([1, 5, 3, 5], 5)
Enum.at([1, 5, 3], 1)
Enum.at(1..6, 2)
Enum.member?([1, 5, 3], 5)
Enum.member?(1..6, 5)
Enum.reverse([1, 2, 3])
Enum.reverse(1..6)
Enum.sort([3, 2, 1])
Enum.uniq([1, 5, 3, 5, 3, 5, 2, 5])
Enum.concat([1, 2, 3], 4..6)

Enum.map([1, 2, 3], fn x -> x * 2 end)
Enum.map(1..3, fn x -> IO.puts(x); x * 2 end)
Enum.filter(1..10, fn x -> rem(x, 2) == 0 end)
Enum.reduce([1, 2, 3], 0, fn x, acc -> x + acc end)
Enum.sum([1, 2, 3])
Enum.reduce(1..3, [], fn x, acc -> [x | acc] end)

Stream.map(1..3, fn x -> IO.puts(x); x * 2 end)
Stream.filter(1..10, fn x -> rem(x, 2) == 0 end)

Enum.take(Enum.filter(1..15, fn x -> IO.puts(x); rem(x, 2) == 0 end), 5)
Enum.take(Stream.filter(1..100, fn x -> IO.puts(x); rem(x, 2) == 0 end), 5)

defmodule MyMath do
  def even?(x) do
    rem(x, 2) == 0
  end

  def square(x) do
    x * x
  end
end

import MyMath

1..15
|> Stream.filter(&even?/1)
|> Stream.map(&square/1)
|> Enum.take(5)

# Prozesse

pid = spawn(fn -> IO.puts("Hello, world!") end)
Process.alive?(pid)

self()
Process.alive?(self())

send(self(), "Hello, world!")

receive do
  message -> IO.puts("Received: #{message}")
after
  1000 -> IO.puts("Timeout")
end


defmodule Receive do
  def once do
    receive do
      message -> IO.puts("Received message: #{inspect(message)}")
    end
  end
end

pid = spawn(fn -> Receive.once() end)
Process.alive?(pid)
send(pid, "Hello, world!")
Process.alive?(pid)

pid = spawn(Receive, :once, [])
send(pid, "Hello, world!")


defmodule Receive do
  def loop do
    receive do
      message -> IO.puts("Received message: #{inspect(message)}")
    end
    loop()
  end
end

pid = spawn(Receive, :loop, [])
Process.alive?(pid)
send(pid, "Hello, world!")
send(pid, "Hello, again")

Process.register(pid, :echo)
send(:echo, "Hello, again and again")

Process.unregister(:echo)
Process.exit(pid, :kill)



defmodule Receive do
  def loop do
    receive do
      {:work, pid} ->
         IO.puts("Received work request from #{inspect(pid)}")
         Process.sleep(1000)
         send(pid, :done)
    end
    loop()
  end
end

pid = spawn(Receive, :loop, [])

send(pid, {:work, self()})
flush()

send(pid, {:work, self()}); flush()
flush()
