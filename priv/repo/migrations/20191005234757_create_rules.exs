defmodule ApiTest.Repo.Migrations.CreateRules do
  use Ecto.Migration

  def change do
    create table(:rules) do
      add :name, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:rules, [:user_id])
  end
end
