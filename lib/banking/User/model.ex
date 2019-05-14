defmodule Banking.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Banking.User
  alias Banking.Account
  alias Comeonin.Bcrypt

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
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}}
        ->
          put_change(changeset, :password, Bcrypt.hashpwsalt(password))
      _ ->
          changeset
    end
  end
end
