defmodule PayStation.Expenses.ExpensesProcessor do
  alias PayStation.Payments.External.Transaction
  alias PayStation.Expenses.Expense
  alias PayStation.Repo

  def handle_messages(messages) do
    new_expenses =
      messages
      |> Enum.map(& &1.value)
      |> Enum.map(& Jason.decode!(&1, as: %Transaction{}))
      |> Enum.map(fn transaction ->
        %{
          transaction_id: Map.get(transaction, "id"),
          quantity:  Map.get(transaction, "quantity"),
          merchant:  Map.get(transaction, "merchant"),
          card_holder_id:  Map.get(transaction, "card_id"),
          inserted_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second),
          updated_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
        }
      end)

    Repo.insert_all(Expense, new_expenses)

    :ok
  end
end
