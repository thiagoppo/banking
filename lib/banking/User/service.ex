defmodule Banking.UserService do
  alias Banking.Repo
  alias Banking.User

  def all() do
    Repo.all(User)
  end

  def get!(id) do
    Repo.get!(User, id)
  end

  def create(params \\ %{}) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()
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
