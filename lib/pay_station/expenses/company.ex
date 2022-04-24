defmodule PayStation.Expenses.Company do
  use Ecto.Schema

  schema "companies" do
    field :name, :string

    timestamps()
  end
end
