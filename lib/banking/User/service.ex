defmodule Banking.UserService do
  alias Banking.Repo
  alias Banking.User
  alias Banking.AccountService

  def all() do
    Repo.all(User)
  end

  def get!(id) do
    Repo.get!(User, id)
  end

  def create(params \\ %{}) do
    with {:ok, user} <- User.changeset(%User{}, params) |> Repo.insert() do
      AccountService.create(user, %{value: 1000.00})
      {:ok, user}
    end
  end

  def update(%User{} = user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end

  def delete(id) do
    Repo.get!(User, id)
    |> Repo.delete()
  end

end
