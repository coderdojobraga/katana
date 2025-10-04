defmodule Katana.Ninjas do
  @moduledoc """
  The Ninjas context.
  """

  import Ecto.Query, warn: false
  alias Ecto.Multi
  alias Katana.Repo

  alias Katana.Ninjas.Ninja
  alias Katana.GuardiansNinjas.GuardianNinja

  @doc """
  Creates a ninja **and** links it to a guardian via GuardianNinja.

  Expects attrs to contain `:guardian_id`.
  """
  def create_ninja(%{guardian_id: guardian_id} = attrs) do
    Multi.new()
    |> Multi.insert(:ninja, Ninja.changeset(%Ninja{}, attrs))
    |> Multi.run(:guardian_ninja, fn _repo, %{ninja: ninja} ->
      %GuardianNinja{}
      |> GuardianNinja.changeset(%{guardian_id: guardian_id, ninja_id: ninja.id})
      |> Repo.insert()
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{ninja: ninja}} -> {:ok, ninja}
      {:error, _step, changeset, _changes} -> {:error, changeset}
    end
  end

  def create_ninja(_attrs) do
    {:error, "guardian_id is required when creating a ninja"}

  end

  @doc """
  Returns all ninjas.
  """
  def list_ninjas do
    Repo.all(Ninja)
  end

  @doc """
  Gets a single ninja by ID.
  Raises `Ecto.NoResultsError` if not found.
  """
  def get_ninja!(id), do: Repo.get!(Ninja, id)

  @doc """
  Updates a ninja.
  """
  def update_ninja(%Ninja{} = ninja, attrs) do
    ninja
    |> Ninja.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ninja.
  """
  def delete_ninja(%Ninja{} = ninja) do
    Repo.delete(ninja)
  end

  @doc """
  Returns all ninjas linked to a given guardian.
  """
  def get_ninjas_for_guardian(guardian_id) do
    query =
      from gn in GuardianNinja,
        where: gn.guardian_id == ^guardian_id,
        join: n in Ninja,
        on: n.id == gn.ninja_id,
        select: n

    Repo.all(query)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ninja changes.
  """
  def change_ninja(%Ninja{} = ninja, attrs \\ %{}) do
    Ninja.changeset(ninja, attrs)
  end
end
