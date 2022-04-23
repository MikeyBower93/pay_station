defmodule PayStation.Payments.PaymentFetcher do
  use GenServer

  alias PayStation.Payments.External.PaymentProcessor

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{})
  end

  @impl true
  def init(state) do
    schedule_work()

    {:ok, state}
  end

  @impl true
  def handle_info(:work, state) do
    transactions =
      PaymentProcessor.fetch_payments()
      |> Enum.map(fn transaction -> {transaction.id, Jason.encode!(transaction)} end)

    Kaffe.Producer.produce_sync("transactions_created", transactions)

    # Reschedule once more
    schedule_work()

    {:noreply, state}
  end

  defp schedule_work do
    Process.send_after(self(), :work, 1000)
  end
end
