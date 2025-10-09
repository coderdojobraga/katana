defmodule Katana.Locations.Location do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "locations" do
    field :name, :string
    field :link, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:name, :link])
    |> validate_required([:name, :link])
    |> update_change(:name, &String.trim/1)
    |> validate_format(:link, ~r/^https?:\/\/.+/, message: "has invalid format")
    |> unsafe_validate_unique(:name, Katana.Repo)
    |> unique_constraint(:name, name: :locations_name_index, message: "has already been taken")
  end
end
