defmodule StackServerTest do
  use ExUnit.Case, async: true
  doctest StackServer

  setup do
    {:ok, stack} = StackServer.start_link()
    %{stack: stack}
  end

  test "new stack is empty", %{stack: stack} do
    assert StackServer.empty?(stack)
  end

  test "pushing an item increases the size", %{stack: stack} do
    StackServer.push(stack, 1)
    assert StackServer.size(stack) == 1
  end

  test "pushing and popping an item returns the item", %{stack: stack} do
    StackServer.push(stack, 1)
    assert StackServer.pop(stack) == 1
  end

  test "pushing and popping multiple items returns the items in reverse order", %{stack: stack} do
    StackServer.push(stack, 1)
    StackServer.push(stack, 2)
    StackServer.push(stack, 3)
    assert StackServer.pop(stack) == 3
    assert StackServer.pop(stack) == 2
    assert StackServer.pop(stack) == 1
  end

  test "popping an empty stack returns :empty", %{stack: stack} do
    assert StackServer.pop(stack) == :empty
  end

  test "top returns the top item", %{stack: stack} do
    StackServer.push(stack, 1)
    assert StackServer.top(stack) == 1
  end

  test "top returns the top item after multiple pushes", %{stack: stack} do
    StackServer.push(stack, 1)
    StackServer.push(stack, 2)
    StackServer.push(stack, 3)
    assert StackServer.top(stack) == 3
  end

  test "top returns :empty for an empty stack", %{stack: stack} do
    assert StackServer.top(stack) == :empty
  end

  test "size returns the number of items in the stack", %{stack: stack} do
    StackServer.push(stack, 1)
    StackServer.push(stack, 2)
    StackServer.push(stack, 3)
    assert StackServer.size(stack) == 3
  end

  test "size returns 0 for an empty stack", %{stack: stack} do
    assert StackServer.size(stack) == 0
  end

  test "empty? returns true for an empty stack", %{stack: stack} do
    assert StackServer.empty?(stack)
  end

  test "empty? returns false for a non-empty stack", %{stack: stack} do
    StackServer.push(stack, 1)
    refute StackServer.empty?(stack)
  end

  test "clear empties the stack", %{stack: stack} do
    StackServer.push(stack, 1)
    StackServer.push(stack, 2)
    StackServer.push(stack, 3)
    StackServer.clear(stack)
    assert StackServer.empty?(stack)
  end

  test "as_list returns the stack as a list", %{stack: stack} do
    StackServer.push(stack, 1)
    StackServer.push(stack, 2)
    StackServer.push(stack, 3)
    assert StackServer.as_list(stack) == [3, 2, 1]
  end

  test "as_list returns an empty list for an empty stack", %{stack: stack} do
    assert StackServer.as_list(stack) == []
  end

  test "sending a :stop message stops the server", %{stack: stack} do
    assert Process.alive?(stack)
    :ok = StackServer.stop(stack)
    refute Process.alive?(stack)
  end
end
