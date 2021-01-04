defmodule Service.Worker do
  def start(_args) do
    spawn_link(fn() -> locked(0) end)
  end
  def loop() do
    receive do
      {:greet, sender} ->
        send sender, "Hi #{inspect sender} from #{inspect self()}"
        loop()
    end
  end
  def locked(state) do
    if fail() do
      raise "BOOM!"
    end
    receive do
      {:coin, sender} ->
        send sender, {:open, self(), "Come in!"}
        unlocked(state)
      {:push, sender} ->
        send sender, {:locked, self(), "Give me a coin and I'll open up for you."}
        locked(state)
      end
    end
  def unlocked(state) do
    if fail() do
      raise "BOOM!"
    end
    receive do
      {:coin, sender} ->
        send sender, {:open, self(), "Come in!"}
        unlocked(state)
      {:push, sender} ->
        send sender, {:locked, self(), "Letting you in and locking the turnstile"}
        locked(state)
    end
  end
  def fail() do
    if :rand.uniform(100) > 90 do
      true
    else
      false
    end
  end
end
