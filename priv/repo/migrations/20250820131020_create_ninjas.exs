defmodule Katana.Repo.Migrations.CreateNinjas do
  use Ecto.Migration

  def change do
    create table(:ninjas, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :full_name, :string
      add :birth_date, :date
      add :has_attended_before, :boolean, default: false, null: false
      add :number_of_sessions, :integer
      add :coderdojo_experience_description, :text
      add :programming_experience_description, :text
      add :has_medical_condition, :boolean, default: false, null: false
      add :medical_condition_details, :text
      add :additional_info, :text
      add :image_consent, :boolean, default: false, null: false
      add :belt, :string

      timestamps(type: :utc_datetime)
    end
  end
end
