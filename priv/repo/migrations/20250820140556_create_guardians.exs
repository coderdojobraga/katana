defmodule Katana.Repo.Migrations.CreateGuardians do
  use Ecto.Migration

  def change do
    create table(:guardians, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :phone, :string

      timestamps(type: :utc_datetime)
    end
  end
end
