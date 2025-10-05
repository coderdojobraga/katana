defmodule Katana.LocationsTest do
  use Katana.DataCase

  alias Katana.Locations
  alias Katana.Locations.Location

  import Katana.LocationsFixtures

  describe "locations" do
    @invalid_attrs %{name: nil, link: nil}

    test "list_locations/0 returns all locations" do
      location = location_fixture()
      assert Locations.list_locations() == [location]
    end

    test "list_locations/0 returns empty list when no locations exist" do
      assert Locations.list_locations() == []
    end

    test "list_locations/0 returns multiple locations" do
      location1 = location_fixture(name: "Location A")
      location2 = location_fixture(name: "Location B")
      locations = Locations.list_locations()

      assert length(locations) == 2
      assert location1 in locations
      assert location2 in locations
    end

    test "get_location!/1 returns the location with given id" do
      location = location_fixture()
      assert Locations.get_location!(location.id) == location
    end

    test "get_location!/1 raises when location does not exist" do
      assert_raise Ecto.NoResultsError, fn ->
        Locations.get_location!(Ecto.UUID.generate())
      end
    end

    test "create_location/1 with valid data creates a location" do
      valid_attrs = %{name: "some name", link: "https://example.com"}

      assert {:ok, %Location{} = location} = Locations.create_location(valid_attrs)
      assert location.name == "some name"
      assert location.link == "https://example.com"
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Locations.create_location(@invalid_attrs)
    end

    test "create_location/1 with missing name returns error changeset" do
      invalid_attrs = %{link: "https://example.com"}

      assert {:error, changeset} = Locations.create_location(invalid_attrs)
      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "create_location/1 with missing link returns error changeset" do
      invalid_attrs = %{name: "some name"}

      assert {:error, changeset} = Locations.create_location(invalid_attrs)
      assert %{link: ["can't be blank"]} = errors_on(changeset)
    end

    test "create_location/1 with empty string name returns error changeset" do
      invalid_attrs = %{name: "", link: "https://example.com"}

      assert {:error, changeset} = Locations.create_location(invalid_attrs)
      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "create_location/1 with empty string link returns error changeset" do
      invalid_attrs = %{name: "some name", link: ""}

      assert {:error, changeset} = Locations.create_location(invalid_attrs)
      assert %{link: ["can't be blank"]} = errors_on(changeset)
    end

    test "create_location/1 with duplicate name returns error changeset" do
      _location = location_fixture(name: "Duplicate Location")
      duplicate_attrs = %{name: "Duplicate Location", link: "https://another.com"}

      assert {:error, changeset} = Locations.create_location(duplicate_attrs)
      assert %{name: ["has already been taken"]} = errors_on(changeset)
    end

    test "create_location/1 with invalid link format returns error changeset" do
      invalid_attrs = %{name: "some name", link: "not a valid url"}

      assert {:error, changeset} = Locations.create_location(invalid_attrs)
      assert %{link: ["has invalid format"]} = errors_on(changeset)
    end

    test "create_location/1 with whitespace-only name returns error changeset" do
      invalid_attrs = %{name: "   ", link: "https://example.com"}

      assert {:error, changeset} = Locations.create_location(invalid_attrs)
      assert %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "update_location/2 with valid data updates the location" do
      location = location_fixture()
      update_attrs = %{name: "some updated name", link: "https://updated.com"}

      assert {:ok, %Location{} = updated_location} =
               Locations.update_location(location, update_attrs)

      assert updated_location.name == "some updated name"
      assert updated_location.link == "https://updated.com"
    end

    test "update_location/2 with invalid data returns error changeset" do
      location = location_fixture()
      assert {:error, %Ecto.Changeset{}} = Locations.update_location(location, @invalid_attrs)
      assert location == Locations.get_location!(location.id)
    end

    test "update_location/2 with duplicate name returns error changeset" do
      _location1 = location_fixture(name: "Location One")
      location2 = location_fixture(name: "Location Two")

      assert {:error, changeset} = Locations.update_location(location2, %{name: "Location One"})
      assert %{name: ["has already been taken"]} = errors_on(changeset)
    end

    test "update_location/2 with invalid link format returns error changeset" do
      location = location_fixture()

      assert {:error, changeset} = Locations.update_location(location, %{link: "invalid url"})
      assert %{link: ["has invalid format"]} = errors_on(changeset)
    end

    test "update_location/2 with same name keeps the location" do
      location = location_fixture(name: "Same Name")

      assert {:ok, %Location{} = updated_location} =
               Locations.update_location(location, %{
                 name: "Same Name",
                 link: "https://newlink.com"
               })

      assert updated_location.name == "Same Name"
      assert updated_location.link == "https://newlink.com"
    end

    test "delete_location/1 deletes the location" do
      location = location_fixture()
      assert {:ok, %Location{}} = Locations.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Locations.get_location!(location.id) end
    end

    test "delete_location/1 is idempotent for already deleted location" do
      location = location_fixture()
      assert {:ok, %Location{}} = Locations.delete_location(location)

      # Attempting to delete again should raise
      assert_raise Ecto.StaleEntryError, fn ->
        Locations.delete_location(location)
      end
    end

    test "change_location/1 returns a location changeset" do
      location = location_fixture()
      assert %Ecto.Changeset{} = Locations.change_location(location)
    end

    test "change_location/1 with new location returns a changeset" do
      changeset = Locations.change_location(%Location{})
      assert changeset.data == %Location{}
      # Empty changeset without data is not valid
      refute changeset.valid?
    end

    test "change_location/2 returns a changeset with given attributes" do
      location = location_fixture()
      attrs = %{name: "New Name"}

      changeset = Locations.change_location(location, attrs)
      assert changeset.changes.name == "New Name"
    end
  end
end
