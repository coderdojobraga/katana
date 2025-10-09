defmodule Katana.Guardians do
  @moduledoc """
  The Guardians context, including links between Guardians and Ninjas.
  """

  import Ecto.Query, warn: false
  alias Katana.Repo

  alias Katana.Guardians.Guardian
  alias Katana.GuardiansNinjas.GuardianNinja
  alias Katana.Ninjas.Ninja

  # --------------------
  # Guardians CRUD
  # --------------------

  @doc """
  Returns the list of guardians.
  """
  def list_guardians do
    Repo.all(Guardian)
  end

  @doc """
  Gets a single guardian.
  """
  def get_guardian!(id), do: Repo.get!(Guardian, id)

  @doc """
  Creates a guardian.
  """
  def create_guardian(attrs \\ %{}) do
    %Guardian{}
    |> Guardian.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a guardian.
  """
  def update_guardian(%Guardian{} = guardian, attrs) do
    guardian
    |> Guardian.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a guardian.
  """
  def delete_guardian(%Guardian{} = guardian) do
    Repo.delete(guardian)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking guardian changes.
  """
  def change_guardian(%Guardian{} = guardian, attrs \\ %{}) do
    Guardian.changeset(guardian, attrs)
  end

  # --------------------
  # GuardianNinja join table CRUD
  # --------------------

  @doc """
  Returns the list of guardian_ninjas.
  """
  def list_guardian_ninjas do
    Repo.all(GuardianNinja)
  end

  @doc """
  Gets a single guardian_ninja.
  """
  def get_guardian_ninja!(id), do: Repo.get!(GuardianNinja, id)

  @doc """
  Creates a guardian_ninja link.
  """
  def create_guardian_ninja(attrs \\ %{}) do
    %GuardianNinja{}
    |> GuardianNinja.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a guardian_ninja link.
  """
  def update_guardian_ninja(%GuardianNinja{} = guardian_ninja, attrs) do
    guardian_ninja
    |> GuardianNinja.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a guardian_ninja link.
  """
  def delete_guardian_ninja(%GuardianNinja{} = guardian_ninja) do
    Repo.delete(guardian_ninja)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking guardian_ninja changes.
  """
  def change_guardian_ninja(%GuardianNinja{} = guardian_ninja, attrs \\ %{}) do
    GuardianNinja.changeset(guardian_ninja, attrs)
  end

  # --------------------
  # Custom Queries
  # --------------------

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
  Returns all Ninjas linked to a given Guardian id.
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
  Creates a link between a Guardian and a Ninja.
  """
  def link_guardian_and_ninja(guardian_id, ninja_id) do
    %GuardianNinja{}
    |> GuardianNinja.changeset(%{guardian_id: guardian_id, ninja_id: ninja_id})
    |> Repo.insert()
  end
end
