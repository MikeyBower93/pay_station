defmodule PayStation.Repo.Migrations.AddExpensesTable do
  use Ecto.Migration

  def change do
    create table("companies") do
      add :name, :string

      timestamps()
    end

    create table("card_holders") do
      add :name, :string
      add :company_id, references(:companies)

      timestamps()
    end

    create table("expenses") do
      add :transaction_id, :string
      add :quantity, :decimal
      add :merchant, :string
      add :reviewed_at, :utc_datetime
      add :reviewed_by, :string
      add :is_company_expense, :boolean

      add :card_holder_id, references(:card_holders)

      timestamps()
    end
  end
end
