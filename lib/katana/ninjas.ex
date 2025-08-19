defmodule Katana.Ninjas do
  @moduledoc """
  The Ninjas context.
  """

  import Ecto.Query, warn: false
  alias Katana.Repo
  alias Katana.Ninja

  @doc """
  Creates a ninja.
  """
  def create_ninja(attrs \\ %{}) do
    %Ninja{}
    |> Ninja.changeset(attrs)
    |> Repo.insert()
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
  Returns an `%Ecto.Changeset{}` for tracking ninja changes.
  """
  def change_ninja(%Ninja{} = ninja, attrs \\ %{}) do
    Ninja.changeset(ninja, attrs)
  end
end
