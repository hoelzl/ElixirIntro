defmodule QueueTest do
  use ExUnit.Case
  doctest Queue

  test "new queue is empty" do
    assert Queue.queue_length(Queue.new()) == 0
  end

  test "length of a new queue with elements is correct" do
    queue = Queue.new([1, 2, 3])
    assert Queue.queue_length(queue) == 3
  end

  test "dequeuing a queue constructed with elements works" do
    queue = Queue.new([1, 2, 3])
    {item, queue} = Queue.dequeue(queue)
    assert item == 1
    assert Queue.queue_length(queue) == 2
    {item, queue} = Queue.dequeue(queue)
    assert item == 2
    assert Queue.queue_length(queue) == 1
    {item, queue} = Queue.dequeue(queue)
    assert item == 3
    assert Queue.queue_length(queue) == 0
  end

  test "length increases after enqueue" do
    queue = Queue.new()
    queue = Queue.enqueue(queue, 1)
    assert Queue.queue_length(queue) == 1
  end

  test "dequeuing an empty queue raises an error" do
    assert_raise RuntimeError, "Cannot dequeue an empty queue", fn ->
      Queue.dequeue(Queue.new())
    end
  end

  test "dequeuing after enqueueing returns the item" do
    queue = Queue.new()
    queue = Queue.enqueue(queue, 1)
    {item, queue} = Queue.dequeue(queue)
    assert item == 1
    assert Queue.queue_length(queue) == 0
  end

  test "dequeuing returns items in enqueuing order" do
    queue = Queue.new()
    queue = Queue.enqueue(queue, 1)
    queue = Queue.enqueue(queue, 2)
    queue = Queue.enqueue(queue, 3)
    {item, queue} = Queue.dequeue(queue)
    assert item == 1
    {item, queue} = Queue.dequeue(queue)
    assert item == 2
    {item, queue} = Queue.dequeue(queue)
    assert item == 3
    assert Queue.queue_length(queue) == 0
  end

  test "mixing dequeueing and enqueueing works" do
    queue = Queue.new()
    queue = Queue.enqueue(queue, 1)
    queue = Queue.enqueue(queue, 2)
    {item, queue} = Queue.dequeue(queue)
    assert item == 1
    queue = Queue.enqueue(queue, 3)
    queue = Queue.enqueue(queue, 4)
    {item, queue} = Queue.dequeue(queue)
    assert item == 2
    {item, queue} = Queue.dequeue(queue)
    assert item == 3
    queue = Queue.enqueue(queue, 5)
    {item, queue} = Queue.dequeue(queue)
    assert item == 4
    {item, queue} = Queue.dequeue(queue)
    assert item == 5
    assert Queue.queue_length(queue) == 0
  end

  test "conversion to list works" do
    queue = Queue.new()
    queue = Queue.enqueue(queue, 1)
    queue = Queue.enqueue(queue, 2)
    queue = Queue.enqueue(queue, 3)
    # Dequeue an item to force the queue to reverse its ins list
    {_item, queue} = Queue.dequeue(queue)
    queue = Queue.enqueue(queue, 4)
    queue = Queue.enqueue(queue, 5)
    assert Queue.to_list(queue) == [2, 3, 4, 5]
  end

end
