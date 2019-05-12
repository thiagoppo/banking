defmodule Banking.UserService do
  alias Banking.Repo
  alias Banking.User
  alias Banking.AccountService

  def all() do
    Repo.all(User) |> Repo.preload(:account)
  end

  def get!(id) do
    Repo.get!(User, id) |> Repo.preload(:account)
  end

  def create(params \\ %{}) do
    with {:ok, user} <- User.changeset(%User{}, params) |> Repo.insert() do
      {:ok, account} = AccountService.create(user, %{value: 1000.00})
      user = Map.put(user, :account, account)
      {:ok, user}
    end
  end

end
