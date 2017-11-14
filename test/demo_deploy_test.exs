defmodule DemoDeployTest do
  use ExUnit.Case
  doctest DemoDeploy

  test "greets the world" do
    assert DemoDeploy.hello() == :world
  end
end
