defmodule DistributedTest.NodeMonitor do
  @moduledoc """
    Monitors the nodes and notifies about any node joining or leaving the cluster.
    If a node leaves, it calls the `ServerSupervisor.start_worker` function.
  """

  alias DistributedTest.ServerSupervisor

  require Logger

  def start_link do
    {:ok, spawn_link fn ->
      :global_group.monitor_nodes true

      monitor()
    end}
  end

  defp monitor do
    receive do
      {:nodeup, node}   ->
        Logger.info "---- Node #{node} joined"

      {:nodedown, node} ->
        Logger.info "---- Node #{node} left"

        ServerSupervisor.start_worker
    end

    monitor()
  end
end
