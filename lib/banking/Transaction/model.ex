defmodule Banking.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  alias Banking.Account
  alias Banking.Transaction

  schema "transactions" do
    belongs_to :account, Account
    field :type, :string
    field :value, :float

    timestamps()
  end

  def changeset(%Transaction{} = transaction, params \\ %{}) do
    transaction
    |> cast(params, [:type, :value])
    |> cast_assoc(:account)
    |> validate_required([:type, :value])
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
