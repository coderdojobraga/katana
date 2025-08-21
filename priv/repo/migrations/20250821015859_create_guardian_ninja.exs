defmodule Katana.Repo.Migrations.CreateGuardianNinja do
  use Ecto.Migration

  def change do
    create table(:guardian_ninja, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :ninja_id, references(:ninjas, type: :binary_id, on_delete: :delete_all), null: false
      add :guardian_id, references(:guardians, type: :binary_id, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:guardian_ninja, [:ninja_id])
    create index(:guardian_ninja, [:guardian_id])
    create unique_index(:guardian_ninja, [:ninja_id, :guardian_id])
  end
end
