defmodule Banking.AccountService do
  alias Banking.Support.Email.EmailService
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

  def draw_out(id, value) do
    account = get!(id)
    value = account.value - value
    with {:ok, account } <- update(account, %{value: value}) do
      EmailService.send("A draw was made to your account. Your current balance is #{value}")
      {:ok, account}
    end
  end

  def update(%Account{} = account, params) do
    account
    |> Account.changeset(params)
    |> Repo.update()
  end

end
