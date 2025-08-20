defmodule Katana.GuardiansFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Katana.Guardians` context.
  """

  @doc """
  Generate a guardian.
  """
  def guardian_fixture(attrs \\ %{}) do
    {:ok, guardian} =
      attrs
      |> Enum.into(%{
        phone: "some phone"
      })
      |> Katana.Guardians.create_guardian()

    guardian
  end
end
