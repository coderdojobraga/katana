defmodule Katana.Repo.Migrations.CreateGuardians do
  use Ecto.Migration

  def change do
    create table(:guardians, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :phone, :string
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:guardians, [:user_id])
  end
end
