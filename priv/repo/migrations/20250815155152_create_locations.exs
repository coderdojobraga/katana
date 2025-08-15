defmodule Katana.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :link, :string

      timestamps(type: :utc_datetime)
    end
  end
end
