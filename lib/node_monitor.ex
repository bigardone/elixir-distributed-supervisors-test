defmodule DistributedTest.NodeMonitor do
  alias DistributedTest.ServerSupervisor

  require Logger

  def start_link do
    {:ok, spawn_link fn ->
      :global_group.monitor_nodes true

      monitor
    end}
  end

  def monitor do
    receive do
      {:nodeup, node}   ->
        Logger.info "---- Node #{node} joined"
      {:nodedown, node} ->
        Logger.info "---- Node #{node} left"

        Supervisor.start_child(ServerSupervisor, [])
    end

    monitor
  end
end
