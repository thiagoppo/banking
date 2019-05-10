defmodule Banking.Repo.Migrations.CreateAccountsTable do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :value, :float
      add :user_id, references(:users, on_delete:​ ​:delete_all)

      timestamps()
    end
  end
end
