defmodule Banking.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias Banking.Account
  alias Banking.User

  schema "accounts" do
    field :value, :float, default: 0.00
    belongs_to :user, User

    timestamps()
  end

  def changeset(%Account{} = account, params \\ %{}) do
    account
    |> cast(params, [:value])
    |> cast_assoc(:user)
    |> validate_required([:value])
  end
end
