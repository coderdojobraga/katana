defmodule Katana.GuardiansNinjas do
  @moduledoc """
  The GuardiansNinjas context.
  """

  import Ecto.Query, warn: false
  alias Katana.Repo

  alias Katana.GuardiansNinjas.GuardianNinja

  @doc """
  Returns the list of guardian_ninja.

  ## Examples

      iex> list_guardian_ninja()
      [%GuardianNinja{}, ...]

  """
  def list_guardian_ninja do
    Repo.all(GuardianNinja)
  end

  @doc """
  Gets a single guardian_ninja.

  Raises `Ecto.NoResultsError` if the Guardian ninja does not exist.

  ## Examples

      iex> get_guardian_ninja!(123)
      %GuardianNinja{}

      iex> get_guardian_ninja!(456)
      ** (Ecto.NoResultsError)

  """
  def get_guardian_ninja!(id), do: Repo.get!(GuardianNinja, id)

  @doc """
  Creates a guardian_ninja.

  ## Examples

      iex> create_guardian_ninja(%{field: value})
      {:ok, %GuardianNinja{}}

      iex> create_guardian_ninja(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_guardian_ninja(attrs \\ %{}) do
    %GuardianNinja{}
    |> GuardianNinja.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a guardian_ninja.

  ## Examples

      iex> update_guardian_ninja(guardian_ninja, %{field: new_value})
      {:ok, %GuardianNinja{}}

      iex> update_guardian_ninja(guardian_ninja, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_guardian_ninja(%GuardianNinja{} = guardian_ninja, attrs) do
    guardian_ninja
    |> GuardianNinja.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a guardian_ninja.

  ## Examples

      iex> delete_guardian_ninja(guardian_ninja)
      {:ok, %GuardianNinja{}}

      iex> delete_guardian_ninja(guardian_ninja)
      {:error, %Ecto.Changeset{}}

  """
  def delete_guardian_ninja(%GuardianNinja{} = guardian_ninja) do
    Repo.delete(guardian_ninja)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking guardian_ninja changes.

  ## Examples

      iex> change_guardian_ninja(guardian_ninja)
      %Ecto.Changeset{data: %GuardianNinja{}}

  """
  def change_guardian_ninja(%GuardianNinja{} = guardian_ninja, attrs \\ %{}) do
    GuardianNinja.changeset(guardian_ninja, attrs)
  end
end
