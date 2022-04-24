defmodule PayStation.Expenses do
  alias PayStation.Repo
  alias PayStation.Expenses.Expense

  import Ecto.Query

  def fetch_expenses(params) do
    base_query =
      from expenses in Expense,
      join: card_holder in assoc(expenses, :card_holder)

    params
    |> Map.to_list()
    |> Enum.reduce(base_query, &filter/2)
    |> Repo.all()
  end

  def get_expense(expense_id) do
    Repo.get!(Expense, expense_id)
  end

  def set_expense_as_reviewed(%Expense{} = expense, reviewed_by, is_company_expense)
    when is_bitstring(reviewed_by) and is_boolean(is_company_expense)
  do
    changeset =
      Ecto.Changeset.change(
        expense,
        reviewed_by: reviewed_by,
        is_company_expense: is_company_expense,
        reviewed_at: DateTime.utc_now() |> DateTime.truncate(:second)
      )

    Repo.update!(changeset)

    Repo.reload(expense)
  end

  defp filter({"company_id", value}, query) do
    from [_expenses, card_holders] in query,
    where: card_holders.company_id == ^value
  end

  defp filter({"card_holder_id", value}, query) do
    from expenses in query,
    where: expenses.card_holder_id == ^value
  end

  defp filter(_param, query), do: query
end
