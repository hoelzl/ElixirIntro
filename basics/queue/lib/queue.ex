defmodule Queue do
  defstruct ins: [], outs: []

  def new(elts \\ []) do
    %Queue{outs: elts}
  end

  def queue_length(%Queue{ins: ins, outs: outs}) do
    length(ins) + length(outs)
  end

  def enqueue(%Queue{ins: ins, outs: outs}, item) do
    %Queue{ins: [item | ins], outs: outs}
  end

  def dequeue(%Queue{ins: [], outs: []}) do
    raise "Cannot dequeue an empty queue"
  end

  def dequeue(%Queue{ins: ins, outs: []}) do
    dequeue(%Queue{ins: [], outs: Enum.reverse(ins)})
  end

  def dequeue(%Queue{ins: ins, outs: [item | outs]}) do
    {item, %Queue{ins: ins, outs: outs}}
  end

  def to_list(%Queue{ins: ins, outs: outs}) do
    outs ++ Enum.reverse(ins)
  end
end

defimpl Enumerable, for: Queue do
  def reduce(_queue, {:halt, acc}, _fun) do
    {:halt, acc}
  end

  def reduce(queue, {:suspend, acc}, fun) do
    {:suspended, acc, &reduce(queue, &1, fun)}
  end

  def reduce(%Queue{ins: [], outs: []}, {:cont, acc}, _fun) do
    {:done, acc}
  end

  def reduce(%Queue{ins: ins, outs: [item | outs]}, {:cont, acc}, fun) do
    reduce(%Queue{ins: ins, outs: outs}, fun.(item, acc), fun)
  end

  def reduce(%Queue{ins: ins, outs: []}, {:cont, acc}, fun) do
    reduce(%Queue{ins: [], outs: Enum.reverse(ins)}, acc, fun)
  end

  def reduce(queue, acc, fun) do
    reduce(queue, {:cont, acc}, fun)
  end

  def count(queue) do
    {:ok, Queue.queue_length(queue)}
  end

  def member?(%Queue{ins: ins, outs: outs}, item) do
    Enum.member?(ins, item) or Enum.member?(outs, item)
  end

  def slice(_queue) do
    {:error, __MODULE__}
  end
end
