defmodule PayStation.ExpensesProcessor do
  alias PayStation.Payments.External.Transaction

  def handle_messages(messages) do
    for %{key: _transaction_id, value: encoded_transaction} <- messages do
      IO.inspect Jason.decode!(encoded_transaction, as: %Transaction{})
    end
    :ok
  end
end
