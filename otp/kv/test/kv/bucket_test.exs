defmodule Kv.BucketTest do
  use ExUnit.Case, async: true

  setup do
    # Don't start servers like this!
    # {:ok, bucket} = KV.Bucket.start_link([])
    bucket = start_supervised!(KV.Bucket, [])
    %{bucket: bucket}
  end

  test "is initially empty", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil
  end

  test "put stores value by key", %{bucket: bucket} do
    KV.Bucket.put(bucket, "milk", 3)

    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "delete deletes value by key", %{bucket: bucket} do
    KV.Bucket.put(bucket, "milk", 3)
    KV.Bucket.delete(bucket, "milk")

    assert KV.Bucket.get(bucket, "milk") == nil
  end

  test "are temporary workers" do
    assert Supervisor.child_spec(KV.Bucket, [])[:restart] == :temporary
  end
end
