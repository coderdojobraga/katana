defmodule Katana.Ninjas.Ninja do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "ninjas" do
    field :full_name, :string
    field :birth_date, :date
    field :has_medical_condition, :boolean, default: false
    field :medical_condition_details, :string
    field :image_consent, :boolean, default: false
    field :belt, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ninja, attrs) do
    ninja
    |> cast(attrs, [
      :full_name,
      :birth_date,
      :has_medical_condition,
      :medical_condition_details,
      :image_consent,
      :belt
    ])
    |> validate_required([
      :full_name,
      :birth_date,
      :image_consent,
      :belt
    ])
    |> validate_medical_condition()
  end

  defp validate_medical_condition(changeset) do
    if get_field(changeset, :has_medical_condition) do
      validate_required(changeset, [:medical_condition_details])
    else
      changeset
    end
  end
end
