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

  def transfer(from_id, destiny_id, value) do
    from_account = get!(from_id)
    destiny_account = get!(destiny_id)

    from_account_value = from_account.value - value
    destiny_account_value = destiny_account.value + value

    case update(from_account, %{value: from_account_value}) do
      {:ok, _} ->
        update(destiny_account, %{value: destiny_account_value})
        {:ok, get!(from_id)}
      {:error, changeset} -> {:error, changeset}
    end
  end

  def update(%Account{} = account, params) do
    account
    |> Account.changeset(params)
    |> Repo.update()
  end

end
