defmodule DistributedTest.Server do
  use GenServer

  require Logger

  # Client

  def start_link() do
    case GenServer.start_link(__MODULE__, %{},name: {:global, __MODULE__}) do
      {:ok, pid} ->
        Logger.info "---- Started #{__MODULE__} master"
        {:ok, pid}
      {:error, {:already_started, pid}} ->
        Logger.info "---- Started #{__MODULE__} slave"
        {:ok, pid}
    end
  end

  def init(state) do
    schedule_work

    {:ok, state}
  end

  def handle_info(:work, state) do
    Logger.info "---- Working..."

    schedule_work

    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 1_000) # Each minute
  end
end
