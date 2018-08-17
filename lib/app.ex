defmodule App do
  use Application

  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: InstanceRegistry},
      {DynamicSupervisor, strategy: :one_for_one, name: InstanceSupervisor}
    ]

    opts = [strategy: :one_for_one, name: AppSupervisor]

    Supervisor.start_link(children, opts)
  end
end
