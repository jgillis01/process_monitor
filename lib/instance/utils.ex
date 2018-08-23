defmodule Utils do
  def subscribe(channel, pid) do
    Registry.register(Notifier, channel, pid)
  end

  def notify(channel, payload) do
    Registry.dispatch(Notifier, channel, fn entries ->
      for {pid, _} <- entries, do: send(pid, {:broadcast, payload})
    end)
  end
end
