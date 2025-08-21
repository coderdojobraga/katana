defmodule Katana.Repo.Migrations.CreateGuardianNinja do
  use Ecto.Migration

  def change do
    create table(:guardian_ninja, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :ninja_id, :uuid
      add :guardian_id, :uuid

      timestamps(type: :utc_datetime)
    end
  end
end
