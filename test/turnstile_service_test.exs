defmodule TurnstileServiceTest do
  use ExUnit.Case
  doctest TurnstileService

  test "greets the world" do
    assert TurnstileService.hello() == :world
  end
end
