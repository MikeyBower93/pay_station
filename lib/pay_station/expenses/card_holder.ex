defmodule PayStation.Expenses.CardHolder do
  use Ecto.Schema

  alias PayStation.Expenses.Company

  schema "card_holders" do
    field :name, :string

    belongs_to :company, Company

    timestamps()
  end
end
