defmodule PayStationWeb.ExpensesController do
  use PayStationWeb, :controller

  alias PayStation.Expenses.Expense
  alias PayStation.Expenses

  def index(conn, params) do
    data =
      params
      |> Expenses.fetch_expenses()
      |> Enum.map(& Map.take(&1, Expense.fields))

    json(conn, data)
  end

  def review(conn, params) do
    expense =
      params["expense_id"]
      |> Integer.parse()
      |> elem(0)
      |> Expenses.get_expense()

    updated_expense =
      Expenses.set_expense_as_reviewed(
        expense,
        params["reviewed_by"],
        params["is_company_expense"]
      )

    json(conn, Map.take(updated_expense, Expense.fields))
  end
end
