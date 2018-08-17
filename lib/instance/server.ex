defmodule Instance.Server do
  use GenServer

  ## Client API
  def start_link(opts) do
    name = opts
           |> Keyword.get(:ip)
           |> name_via_registry()

    GenServer.start_link(__MODULE__, opts, name: name)
  end

  def execute_command(instance, command) do
    name = name_via_registry(instance)
    GenServer.call(name, {:execute_command, command})
  end

  ## Server API
  def init(opts) do
    SSHEx.connect(opts)
  end

  def handle_call({:execute_command, command}, _from, conn) do
    result = SSHEx.cmd!(conn, command)
    {:reply, result, conn}
  end

  defp name_via_registry(instance) do
    {:via, Registry, {InstanceRegistry, instance}}
  end
end
