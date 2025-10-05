defmodule Katana.LocationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Katana.Locations` context.
  """

  def location_fixture(attrs \\ %{}) do
    unique_id = System.unique_integer([:positive])

    {:ok, location} =
      attrs
      |> Enum.into(%{
        name: "Location #{unique_id}",
        link: "https://example-#{unique_id}.com"
      })
      |> Katana.Locations.create_location()

    location
  end
end
