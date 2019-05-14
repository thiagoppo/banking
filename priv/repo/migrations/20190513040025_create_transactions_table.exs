defmodule Banking.Repo.Migrations.CreateTransactionsTable do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :account_id, references(:accounts, on_delete: :delete_all)
      add :type, :string
      add :value, :float

      timestamps()
    end
  end
end
