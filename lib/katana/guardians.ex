defmodule Katana.Guardians do
  @moduledoc """
  The Guardians context.
  """

  import Ecto.Query, warn: false
  alias Katana.Repo
  alias Katana.Guardians.Guardian
  alias Katana.GuardiansNinjas.GuardianNinja

  @doc """
  Returns the list of guardians.

  ## Examples

      iex> list_guardians()
      [%Guardian{}, ...]

  """
  def list_guardians do
    Repo.all(Guardian)
  end

  @doc """
  Gets a single guardian.

  Raises `Ecto.NoResultsError` if the Guardian does not exist.

  ## Examples

      iex> get_guardian!(123)
      %Guardian{}

      iex> get_guardian!(456)
      ** (Ecto.NoResultsError)

  """
  def get_guardian!(id), do: Repo.get!(Guardian, id)

  @doc """
  Creates a guardian.

  ## Examples

      iex> create_guardian(%{field: value})
      {:ok, %Guardian{}}

      iex> create_guardian(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_guardian(attrs \\ %{}) do
    %Guardian{}
    |> Guardian.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a guardian.

  ## Examples

      iex> update_guardian(guardian, %{field: new_value})
      {:ok, %Guardian{}}

      iex> update_guardian(guardian, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_guardian(%Guardian{} = guardian, attrs) do
    guardian
    |> Guardian.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a guardian.

  ## Examples

      iex> delete_guardian(guardian)
      {:ok, %Guardian{}}

      iex> delete_guardian(guardian)
      {:error, %Ecto.Changeset{}}

  """
  def delete_guardian(%Guardian{} = guardian) do
    Repo.delete(guardian)
  end

  @doc """
  Returns all Guardians linked to a given Ninja id.
  """
  def get_guardians_for_ninja(ninja_id) do
    query =
      from gn in GuardianNinja,
        where: gn.ninja_id == ^ninja_id,
        join: g in Guardian,
        on: g.id == gn.guardian_id,
        select: g

    Repo.all(query)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking guardian changes.

  ## Examples

      iex> change_guardian(guardian)
      %Ecto.Changeset{data: %Guardian{}}

  """
  def change_guardian(%Guardian{} = guardian, attrs \\ %{}) do
    Guardian.changeset(guardian, attrs)
  end
end
