defmodule Katana.GuardiansNinjasTest do
  use Katana.DataCase

  alias Katana.GuardiansNinjas

  describe "guardian_ninja" do
    alias Katana.GuardiansNinjas.GuardianNinja

    import Katana.GuardiansNinjasFixtures

    @invalid_attrs %{ninja_id: nil, guardian_id: nil}

    test "list_guardian_ninja/0 returns all guardian_ninja" do
      guardian_ninja = guardian_ninja_fixture()
      assert GuardiansNinjas.list_guardian_ninja() == [guardian_ninja]
    end

    test "get_guardian_ninja!/1 returns the guardian_ninja with given id" do
      guardian_ninja = guardian_ninja_fixture()
      assert GuardiansNinjas.get_guardian_ninja!(guardian_ninja.id) == guardian_ninja
    end

    test "create_guardian_ninja/1 with valid data creates a guardian_ninja" do
      valid_attrs = %{ninja_id: "7488a646-e31f-11e4-aace-600308960662", guardian_id: "7488a646-e31f-11e4-aace-600308960662"}

      assert {:ok, %GuardianNinja{} = guardian_ninja} = GuardiansNinjas.create_guardian_ninja(valid_attrs)
      assert guardian_ninja.ninja_id == "7488a646-e31f-11e4-aace-600308960662"
      assert guardian_ninja.guardian_id == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_guardian_ninja/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GuardiansNinjas.create_guardian_ninja(@invalid_attrs)
    end

    test "update_guardian_ninja/2 with valid data updates the guardian_ninja" do
      guardian_ninja = guardian_ninja_fixture()
      update_attrs = %{ninja_id: "7488a646-e31f-11e4-aace-600308960668", guardian_id: "7488a646-e31f-11e4-aace-600308960668"}

      assert {:ok, %GuardianNinja{} = guardian_ninja} = GuardiansNinjas.update_guardian_ninja(guardian_ninja, update_attrs)
      assert guardian_ninja.ninja_id == "7488a646-e31f-11e4-aace-600308960668"
      assert guardian_ninja.guardian_id == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_guardian_ninja/2 with invalid data returns error changeset" do
      guardian_ninja = guardian_ninja_fixture()
      assert {:error, %Ecto.Changeset{}} = GuardiansNinjas.update_guardian_ninja(guardian_ninja, @invalid_attrs)
      assert guardian_ninja == GuardiansNinjas.get_guardian_ninja!(guardian_ninja.id)
    end

    test "delete_guardian_ninja/1 deletes the guardian_ninja" do
      guardian_ninja = guardian_ninja_fixture()
      assert {:ok, %GuardianNinja{}} = GuardiansNinjas.delete_guardian_ninja(guardian_ninja)
      assert_raise Ecto.NoResultsError, fn -> GuardiansNinjas.get_guardian_ninja!(guardian_ninja.id) end
    end

    test "change_guardian_ninja/1 returns a guardian_ninja changeset" do
      guardian_ninja = guardian_ninja_fixture()
      assert %Ecto.Changeset{} = GuardiansNinjas.change_guardian_ninja(guardian_ninja)
    end
  end
end
