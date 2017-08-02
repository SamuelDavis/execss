defmodule ExecssTest do
  use ExUnit.Case
  doctest Execss

  test "render system does nothing on invalid render state" do
    assert %{render: 'foo'} = Execss.render_system(%{render: 'foo'})
  end

  test "render system initializes render state" do
    assert %{render: 0} = Execss.render_system(%{})
  end

  test "render system increments render state" do
    assert %{render: 2} = Execss.render_system(%{render: 1})
  end
end
