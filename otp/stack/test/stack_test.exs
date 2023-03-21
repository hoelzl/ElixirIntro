defmodule StackTest do
  use ExUnit.Case
  doctest Stack

  setup do
    {:ok, stack_pid} = Stack.start_link()
    %{stack_pid: stack_pid}
  end

  test "initial stack size is 0", %{stack_pid: stack_pid} do
    assert Stack.size(stack_pid) == 0
  end

  test "popping an empty stack returns :empty", %{stack_pid: stack_pid} do
    assert Stack.pop(stack_pid) == :empty
  end

  test "pushing an item increases the stack size", %{stack_pid: stack_pid} do
    assert Stack.push(stack_pid, 1) == :ok
    assert Stack.size(stack_pid) == 1
  end

  test "popping an item returns the previously pushed item", %{stack_pid: stack_pid} do
    assert Stack.push(stack_pid, 1) == :ok
    assert Stack.pop(stack_pid) == {:ok, 1}
  end

  test "items are popped in LIFO order", %{stack_pid: stack_pid} do
    assert Stack.push(stack_pid, 1) == :ok
    assert Stack.push(stack_pid, 2) == :ok
    assert Stack.pop(stack_pid) == {:ok, 2}
    assert Stack.pop(stack_pid) == {:ok, 1}
    assert Stack.pop(stack_pid) == :empty
  end
end
