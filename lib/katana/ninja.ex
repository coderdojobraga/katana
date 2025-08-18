defmodule Katana.Ninja do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "ninjas" do
    field :full_name, :string
    field :birth_date, :date
    field :has_attended_before, :boolean, default: false
    field :number_of_sessions, :integer
    field :coderdojo_experience_description, :string
    field :programming_experience_description, :string
    field :has_medical_condition, :boolean, default: false
    field :medical_condition_details, :string
    field :additional_info, :string
    field :image_consent, :boolean, default: false
    field :belt, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ninja, attrs) do
    ninja
    |> cast(attrs, [:full_name, :birth_date, :has_attended_before, :number_of_sessions, :coderdojo_experience_description, :programming_experience_description, :has_medical_condition, :medical_condition_details, :additional_info, :image_consent, :belt])
    |> validate_required([:full_name, :birth_date, :has_attended_before, :number_of_sessions, :coderdojo_experience_description, :programming_experience_description, :has_medical_condition, :medical_condition_details, :additional_info, :image_consent, :belt])
  end
end
