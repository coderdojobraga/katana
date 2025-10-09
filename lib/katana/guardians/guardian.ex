defmodule Katana.Guardians.Guardian do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "guardians" do
    field :phone, :string

    belongs_to :user, Katana.Accounts.User, type: :binary_id

    timestamps(type: :utc_datetime)
  end

  def changeset(guardian, attrs) do
    guardian
    |> cast(attrs, [:phone, :user_id])
    |> validate_required([:phone, :user_id])
  end
end
