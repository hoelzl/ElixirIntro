# Zahlen

# Integer
1
0x1F
0b1010
12_345_678_901_234_567_890_123_456_789_012_345_678_901_234_567_890

# Float
0.1
1.0e-10

# Atome
:atom
:atom_with_underscore
:atom_with_underscore_and_123

# Strings
"Hello World"
"Hello \"World\""
'Hello World'

# Tupel
{1, 2, 3}
{1, :atom, "Hello, world!"}

# Listen
[1, 2, 3]
[1, :atom, "Hello, world!"]
[1 | [2]]
[1, 2 | [3, 4, 5]]

# Maps
%{key: "value"}
%{key: "value", key2: "value2"}
%{:key => "value"}
%{"key" => "value"}
%{1 => "value"}

# Binaries
<<1, 2, 3>>
<<1, 2, 3::size(8)>>
<<1, 2, 3::size(16)>>
<<1::size(1), 0::size(1)>>

# Regular Expressions
~r/regex/
~r/regex/i

"regex" =~ ~r/regex/
"Regex" =~ ~r/regex/
"Regex" =~ ~r/regex/i
"aaabbbaaa" =~ ~r/a+b{3}a*/
"abbb" =~ ~r/a+b{3}a*/
"abba" =~ ~r/a+b{3}a*/

# Operatoren

# Mathematische Operatoren
1 + 2
1 - 2
1 * 2
1 / 2
1 / 2.0

# Vergleichsoperatoren
1 == 2
1 != 2
1 < 2
1 <= 2
1 > 2
1 >= 2

# Logische Operatoren
true and false
true or false
not true

1 && 2
1 || 2

# Bitweise Operatoren
use Bitwise
1 <<< 2
16 >>> 2
14 &&& 7

# Definieren von Modulen, Funktionen und Variablen

defmodule MyModule do
  def my_function(arg1, arg2) do
    arg1 + arg2
  end

  def your_function do
    tmp = 1 + 2
    tmp * 2
  end

  def not_so_secret do
    secret()
  end

  defp secret do
    "This is a secret!"
  end
end

# Aufrufen von Funktionen
MyModule.my_function(1, 2)
MyModule.my_function(1, 2)
MyModule.your_function()
MyModule.your_function()
MyModule.not_so_secret()
# MyModule.secret()

# Pattern Matching
defmodule MyModule do
  def my_function(1, 2) do
    "Matched!"
  end

  def my_function(_, _) do
    "Not matched!"
  end
end

MyModule.my_function(1, 2)
MyModule.my_function(1, 3)

# Pattern Matching mit Listen
defmodule MyModule do
  def my_function([h | t]) do
    "Matched: #{inspect(h)} and #{inspect(t)}"
  end

  def my_function([]) do
    "Matched: []"
  end

  def my_function(_) do
    "Not matched!"
  end
end

MyModule.my_function([1, 2, 3])
MyModule.my_function([])
MyModule.my_function(1)

# Pattern Matching mit Tupeln
defmodule MyModule do
  def my_function({:ok, result}) do
    "Matched: #{inspect(result)}"
  end

  def my_function({:error, reason}) do
    "Matched: #{inspect(reason)}"
  end

  def my_function(_) do
    "Not matched!"
  end
end

MyModule.my_function({:ok, 1})
MyModule.my_function({:error, "Something went wrong!"})
MyModule.my_function(1)

# Pattern Matching mit Maps

defmodule MyModule do
  def my_function(%{key: value}) do
    "Matched: #{inspect(value)}"
  end

  def my_function(_) do
    "Not matched!"
  end
end

MyModule.my_function(%{key: "value"})
MyModule.my_function(%{key: "value", key2: "value2"})
MyModule.my_function(%{:key => "value"})
MyModule.my_function(%{"key" => "value"})

# Pattern Matching mit Variablen

defmodule MyModule do
  def return_tuple do
    {:ok, 1}
  end

  def foo do
    {:ok, result} = return_tuple()
    result
  end
end

MyModule.foo()

# Modulattribute

defmodule MyModule do
  @my_value 1
  def my_function do
    @my_value
  end

  @my_value 2
  def your_function do
    @my_value
  end
end

MyModule.my_function()
MyModule.your_function()

# Anonyme Funktionen
my_fun = fn x -> x + 1 end
my_fun.(1)

your_fun = &(1 + &1)
your_fun.(1)

their_fun = &Process.alive?/1
their_fun.(self())

# Kontrollstrukturen

# if
defmodule MyModule do
  def my_function(x) do
    if x == 2 do
      "x is equal to 2"
    else
      "x is not equal to 2"
    end
  end
end

MyModule.my_function(1)
MyModule.my_function(2)

# case
defmodule MyModule do
  def my_function(x) do
    case x do
      1 -> "x is equal to 1"
      2 -> "x is equal to 2"
      _ -> "x is not equal to 1 or 2"
    end
  end
end

MyModule.my_function(1)
MyModule.my_function(2)
MyModule.my_function(3)

# Schleifen

defmodule MyModule do
  def recursive_loop(0) do
    IO.puts("Done!")
  end

  def recursive_loop(n) do
    IO.puts(n)
    recursive_loop(n - 1)
  end

  def loop_with_for do
    for i <- 1..10 do
      IO.puts(i)
    end
  end
end

MyModule.recursive_loop(10)
MyModule.loop_with_for()

# Exceptions
defmodule MyModule do
  def my_function do
    raise "This is an error!"
  end

  def your_function do
    try do
      raise "This is an error!"
    rescue
      RuntimeError -> "This is a RuntimeError"
    after
      IO.puts("This is always executed")
    end
  end

  def their_function do
    raise "This is an error!"
  rescue
    RuntimeError -> "This is a RuntimeError"
  after
    IO.puts("This is always executed")
  end
end

MyModule.my_function()
MyModule.your_function()
MyModule.their_function()

# Collections

# Listen

[1, 2, 3]
[1 | [2, 3]]
[1 | [2 | [3 | []]]]

List.first([1, 2, 3])
List.last([1, 2, 3])
List.delete_at([1, 2, 3], 1)
List.insert_at([1, 2, 3], 1, 4)
Enum.at([1, 2, 3], 1)
Enum.member?([1, 2, 3], 1)
1 in [1, 2, 3]
Enum.reverse([1, 2, 3])
Enum.sort([3, 2, 1])
Enum.uniq([1, 2, 1, 3, 2, 3])
Enum.concat([1, 2], [3, 4])
Enum.map([1, 2, 3], fn x -> x * 2 end)
Enum.filter([1, 2, 3], fn x -> x > 1 end)
Enum.reduce([1, 2, 3], 0, fn x, acc -> x + acc end)
Enum.sum([1, 2, 3])

# Maps

%{key: "value"}
Map.put(%{key: "value"}, :key2, "value2")
my_map = %{key: "value", key2: "value2"}
Map.get(my_map, :key)
%{my_map | key2: "new-value"}
my_map
my_map = %{my_map | key2: "new-value"}
my_map
Map.delete(my_map, :key2)
my_map
Map.keys(my_map)

# Sets
MapSet.new()
MapSet.new([1, 2, 3])
MapSet.put(MapSet.new([1, 2, 3]), 4)
MapSet.put(MapSet.new([1, 2, 3]), 2)
MapSet.delete(MapSet.new([1, 2, 3]), 2)
my_map = MapSet.new([1, 2, 3])
Enum.map(my_map, fn x -> x * 2 end)
Enum.filter(my_map, fn x -> x > 1 end)

# Pipes

[1, 2, 3, 4, 5, 6]
|> Enum.map(fn x -> x * 2 end)
|> Enum.filter(fn x -> x > 5 end)

# Comprehensions
for x <- [1, 2, 3], do: x * 2

for x <- [1, 2, 3] do
  x * 2
end

for x <- [1, 2, 3], y <- [4, 5, 6], do: {x, y}
for x <- [1, 2, 3], y <- [1, 2, 3], x < y, do: {x, y}
for x <- [1, 2, 3], y <- [4, 5, 6], into: %{}, do: {x, y}

for x <- [1, 2, 3], reduce: 0 do
  acc -> acc + x
end

# Structs

defmodule MyPoint.Struct1 do
  defstruct a: 0, b: 0, c: 0
end

s = %MyPoint.Struct1{b: 10}
s.a
s.b
%MyPoint.Struct1{s | a: 20}

defmodule MyPoint do
  defmodule Struct2 do
    defstruct a: 0, b: 0, c: 0
  end
  defstruct x: 0, y: 0
end

%MyPoint{}
%MyPoint{x: 1, y: 2}
%MyPoint.Struct2{}

defmodule MyPoint do
  defstruct x: 0, y: 0

  def add(%MyPoint{x: x1, y: y1}, %MyPoint{x: x2, y: y2}) do
    %MyPoint{x: x1 + x2, y: y1 + y2}
  end
end

my_point = %MyPoint{x: 1, y: 2}
your_point = %MyPoint{x: 3, y: 4}
MyPoint.add(my_point, your_point)

# Protokolle

defprotocol Describable do
  def describe(data)
end

defimpl Describable, for: Integer do
  @impl true
  def describe(data) do
    "This is an Integer: #{inspect(data)}"
  end
end

defimpl Describable, for: MyPoint do
  def describe(data) do
    "This is a very special point: #{inspect(data)}"
  end
end

defimpl Describable, for: Any do
  def describe(data) do
    "This is an unknown data type: #{inspect(data)}"
  end
end

Describable.describe(1)
Describable.describe(%MyPoint{})
# Describable.describe("Hello")

defmodule MyThing do
  @derive Describable
  defstruct name: "Thing"
end

Describable.describe(%MyThing{})

defprotocol Fixable do
  @fallback_to_any true
  def fix(data)
end

defimpl Fixable, for: Any do
  def fix(data) do
    IO.puts("Fixing #{inspect(data)}")
    data
  end
end

defimpl Fixable, for: Integer do
  def fix(data) do
    data + 1
  end
end

Fixable.fix(1)
Fixable.fix("Hello")

# Prozesse

pid = spawn(fn -> IO.puts("Hello from a process!") end)
Process.alive?(pid)

self()
Process.alive?(self())

# Nachrichten
send(self(), "Hello from myself!")

receive do
  message -> IO.puts("Received message: #{inspect(message)}")
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
send(pid, "Hello, there!")
Process.alive?(pid)

defmodule Receive do
  def loop do
    receive do
      message -> IO.puts("Received message: #{inspect(message)}")
    end
    loop()
  end
end

pid = spawn(fn -> Receive.loop() end)
Process.alive?(pid)
send(pid, "Hello, there!")
Process.alive?(pid)
send(pid, "Hello, again!")
Process.alive?(pid)
send(pid, "Ich sag einfach Hello, again!")

Process.alive?(pid)
Process.register(pid, :echo)
send(:echo, "Du, ich möchte dich heut noch sehn")

# Tasks
{:ok, task} = Task.start(fn -> IO.puts("Hello from a task!") end)
Process.alive?(task)
