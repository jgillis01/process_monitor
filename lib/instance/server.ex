defmodule Instance.Server do
  use GenServer

  ## Client API
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  def execute_command(pid, command) do
    GenServer.call(pid, {:execute_command, command})
  end

  ## Server API
  def init(opts) do
    SSHEx.connect(opts)
  end

  def handle_call({:execute_command, command}, _from, conn) do
    result = SSHEx.cmd!(conn, command)
    {:reply, result, conn}
  end
end
