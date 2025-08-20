defmodule Katana.LocationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Katana.Locations` context.
  """

  @doc """
  Generate a location.
  """
  def location_fixture(attrs \\ %{}) do
    {:ok, location} =
      attrs
      |> Enum.into(%{
        link: "some link",
        name: "some name"
      })
      |> Katana.Locations.create_location()

    location
  end
end
