defmodule Katana.GuardiansNinjas.GuardianNinja do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "guardian_ninja" do
    field :ninja_id, :binary_id
    field :guardian_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(guardian_ninja, attrs) do
    guardian_ninja
    |> cast(attrs, [:ninja_id, :guardian_id])
    |> validate_required([:ninja_id, :guardian_id])
  end
end
