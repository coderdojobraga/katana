defmodule Katana.Repo.Migrations.CreateNinjas do
  use Ecto.Migration

  def change do
    create table(:ninjas, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :full_name, :string, null: false
      add :birth_date, :date, null: false
      add :has_medical_condition, :boolean, default: false, null: false
      add :medical_condition_details, :string
      add :image_consent, :boolean, default: false, null: false
      add :belt, :string, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
