defmodule DistributedTest.ServerSupervisor do
  use Supervisor

  alias DistributedTest.Server

  def start_link, do: Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)

  def init(:ok) do
    children = [worker(Server, [], restart: :transient)]
    supervise(children, strategy: :simple_one_for_one)
  end

  def start_worker, do: Supervisor.start_child(__MODULE__, [])
end
