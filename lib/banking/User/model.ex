defmodule Banking.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Banking.User

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string

    timestamps()
  end

  def changeset(%User{} = user, params \\ %{}) do
    user
    |> cast(params, [:email, :name, :password])
    |> validate_required([:email, :name, :password])
    |> unique_constraint(:email)
  end
end
