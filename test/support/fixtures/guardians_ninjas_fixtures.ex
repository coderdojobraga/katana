defmodule Katana.GuardiansNinjasFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Katana.GuardiansNinjas` context.
  """

  @doc """
  Generate a guardian_ninja.
  """
  def guardian_ninja_fixture(attrs \\ %{}) do
    {:ok, guardian_ninja} =
      attrs
      |> Enum.into(%{
        guardian_id: "7488a646-e31f-11e4-aace-600308960662",
        ninja_id: "7488a646-e31f-11e4-aace-600308960662"
      })
      |> Katana.GuardiansNinjas.create_guardian_ninja()

    guardian_ninja
  end
end
