defmodule PayStation.Expenses.Expense do
  use Ecto.Schema

  alias PayStation.Expenses.CardHolder

  def fields, do: [:id, :transaction_id, :quantity, :merchant, :reviewed_at, :reviewed_by, :is_company_expense]

  schema "expenses" do
    field :transaction_id, :string
    field :quantity, :decimal
    field :merchant, :string
    field :reviewed_at, :utc_datetime
    field :reviewed_by, :string
    field :is_company_expense, :boolean

    belongs_to :card_holder, CardHolder

    timestamps()
  end
end
