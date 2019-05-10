defmodule Banking.AccountService do
  alias Banking.Repo
  alias Banking.Account
  alias Banking.User

  def all() do
    Repo.all(Account)
  end

  def get!(id) do
    Repo.get!(Account, id)
  end

  def create(%User{} = user, params \\ %{}) do
    account_with_user = Ecto.build_assoc(user, :account)
    Account.changeset(account_with_user, params)
    |> Repo.insert()
  end

  def update(%Account{} = account, params) do
    account
    |> Account.changeset(params)
    |> Repo.update()
  end

  def delete(id) do
    Repo.get!(Account, id)
    |> Repo.delete()
  end

end
