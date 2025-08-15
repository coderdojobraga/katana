defmodule Katana.Repo.Seeds.Locations do
  @moduledoc """
  MLocations seeding
  """

  alias Katana.Location
  alias Katana.Locations
  alias Katana.Repo

  def run do
    case Repo.all(Location) do
      [] ->
        seed_locations()

      _ ->
        Mix.shell().error("Found Locations, aborting seeding locations.")
    end
  end

   defp seed_locations do
    locations = [
      %{name: "CeSIUM-DI", link: "https://maps.app.goo.gl/T5CWCEZCnoZB6sPdA"},
      %{name: "gnration", link: "https://maps.app.goo.gl/2YKJbXPFvRzgnpSg9"}
    ]

    for attrs <- locations do
      case Locations.create_location(attrs) do
        {:ok, _location} ->
          Mix.shell().info("Created location: #{attrs.name}")

        {:error, changeset} ->
          Mix.shell().error("Error creating #{attrs.name}: #{inspect(changeset.errors)}")
      end
    end
  end
end

Katana.Repo.Seeds.Locations.run()
