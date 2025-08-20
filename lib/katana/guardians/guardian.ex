defmodule Katana.Guardians.Guardian do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "guardians" do
    field :phone, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(guardian, attrs) do
    guardian
    |> cast(attrs, [:phone])
    |> validate_required([:phone])
  end
end
