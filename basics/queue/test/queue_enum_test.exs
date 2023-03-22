defmodule QueueEnumTest do
  use ExUnit.Case

  setup do
    queue = Queue.new()
    queue = Queue.enqueue(queue, 0)
    queue = Queue.enqueue(queue, 1)
    queue = Queue.enqueue(queue, 2)
    queue = Queue.enqueue(queue, 3)
    # Dequeue an item to force the queue to reverse its ins list
    {_item, queue} = Queue.dequeue(queue)
    queue = Queue.enqueue(queue, 4)
    queue = Queue.enqueue(queue, 5)
    %{queue: queue}
  end

  test "all? works for queues", %{queue: queue} do
    assert Enum.all?(queue, &(&1 > 0))
    assert !Enum.all?(queue, &(&1 > 1))
  end

  test "any? works for queues", %{queue: queue} do
    assert Enum.any?(queue, &(&1 == 2))
    assert !Enum.any?(queue, &(&1 > 5))
  end

  test "at works for queues", %{queue: queue} do
    assert Enum.at(queue, 0) == 1
    assert Enum.at(queue, 1) == 2
    assert Enum.at(queue, 2) == 3
    assert Enum.at(queue, 3) == 4
    assert Enum.at(queue, 4) == 5
    assert Enum.at(queue, 5) == nil
  end

  test "chunking a queue works", %{queue: queue} do
    assert Enum.chunk_every(queue, 2) == [[1, 2], [3, 4], [5]]
    assert Enum.chunk_every(queue, 2, 2, :discard) == [[1, 2], [3, 4]]
    assert Enum.chunk_every(queue, 3, 1) == [[1, 2, 3], [2, 3, 4], [3, 4, 5], [4, 5]]
  end

  test "concatenating queues works", %{queue: queue} do
    assert Enum.concat(queue, [6, 7, 8]) == [1, 2, 3, 4, 5, 6, 7, 8]
  end

  test "count works for queues", %{queue: queue} do
    assert Enum.count(queue) == 5
    assert Enum.count(queue, &(&1 > 2)) == 3
  end

  test "mapping over a queue works", %{queue: queue} do
    assert Enum.map(queue, &(&1 * 2)) == [2, 4, 6, 8, 10]
  end
end
