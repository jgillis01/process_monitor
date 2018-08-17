defmodule ProcessMonitor do
  alias Instance.Server

  def add_instance_connection(opts) do
    DynamicSupervisor.start_child(InstanceSupervisor, {Server, opts})
  end

  defdelegate execute_command(instance, command), to: Server
end
