defmodule Katana.NinjasFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Katana.Ninjas` context.
  """

  @doc """
  Generate a ninja.
  """
  def ninja_fixture(attrs \\ %{}) do
    {:ok, ninja} =
      attrs
      |> Enum.into(%{
        full_name: "some full_name",
        birth_date: ~D[2025-08-19],
        has_medical_condition: true,
        medical_condition_details: "some medical_condition_details",
        image_consent: true,
        belt: "yellow"
      })
      |> Katana.Ninjas.create_ninja()

    ninja
  end
end
