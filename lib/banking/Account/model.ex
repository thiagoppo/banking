defmodule Banking.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias Banking.Account
  alias Banking.User
  alias Banking.Transaction

  schema "accounts" do
    field :value, :float, default: 0.00
    belongs_to :user, User
    has_many :transactions, Transaction

    timestamps()
  end

  def changeset(%Account{} = account, params \\ %{}) do
    account
    |> cast(params, [:value])
    |> cast_assoc(:user)
    |> validate_required([:value])
    |> validate_is_not_negative(:value)
  end

  defp validate_is_not_negative(changeset, field) do
    value = get_field(changeset, field)
    if value < 0.00 do
      add_error(changeset, field, "can't be negative")
    else
      changeset
    end
  end
end
