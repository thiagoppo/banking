defmodule Banking.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Banking.User
  alias Banking.Account

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string
    has_one :account, Account

    timestamps()
  end

  def changeset(%User{} = user, params \\ %{}) do
    user
    |> cast(params, [:email, :name, :password])
    |> validate_required([:email, :name, :password])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end
