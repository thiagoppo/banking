defmodule Banking.TransactionService do
  import Ecto.Query, only: [from: 2]
  alias Banking.Repo
  alias Banking.Transaction
  alias Banking.Account

  def all() do
    Repo.all(Transaction)
  end

  def filter_by_account_id(account_id) do
    query = from t in Transaction, where: t.account_id == ^account_id
    Repo.all(query)
  end

  def create(%Account{} = account, params \\ %{}) do
    transaction_with_account = Ecto.build_assoc(account, :transactions)
    Transaction.changeset(transaction_with_account, params)
    |> Repo.insert()
  end

end
