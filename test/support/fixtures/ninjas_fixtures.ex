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
        additional_info: "some additional_info",
        belt: "some belt",
        birth_date: ~D[2025-08-19],
        coderdojo_experience_description: "some coderdojo_experience_description",
        full_name: "some full_name",
        has_attended_before: true,
        has_medical_condition: true,
        image_consent: true,
        medical_condition_details: "some medical_condition_details",
        number_of_sessions: 42,
        programming_experience_description: "some programming_experience_description"
      })
      |> Katana.Ninjas.create_ninja()

    ninja
  end
end
