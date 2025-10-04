defmodule Katana.NinjasTest do
  use Katana.DataCase

  alias Katana.Ninjas

  describe "ninjas" do
    alias Katana.Ninjas.Ninja

    import Katana.NinjasFixtures

    @invalid_attrs %{
      full_name: nil,
      birth_date: nil,
      has_medical_condition: nil,
      medical_condition_details: nil,
      image_consent: nil,
      belt: nil
    }

    test "list_ninjas/0 returns all ninjas" do
      ninja = ninja_fixture()
      assert Ninjas.list_ninjas() == [ninja]
    end

    test "get_ninja!/1 returns the ninja with given id" do
      ninja = ninja_fixture()
      assert Ninjas.get_ninja!(ninja.id) == ninja
    end

    test "create_ninja/1 with valid data creates a ninja" do
      valid_attrs = %{
        full_name: "some full_name",
        birth_date: ~D[2025-08-19],
        has_medical_condition: true,
        medical_condition_details: "some medical_condition_details",
        image_consent: true,
        belt: "Yellow"
      }

      assert {:ok, %Ninja{} = ninja} = Ninjas.create_ninja(valid_attrs)
      assert ninja.full_name == "some full_name"
      assert ninja.birth_date == ~D[2025-08-19]
      assert ninja.has_medical_condition == true
      assert ninja.medical_condition_details == "some medical_condition_details"
      assert ninja.image_consent == true
      assert ninja.belt == "Yellow"
    end

    test "create_ninja/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ninjas.create_ninja(@invalid_attrs)
    end

    test "update_ninja/2 with valid data updates the ninja" do
      ninja = ninja_fixture()

      update_attrs = %{
        full_name: "some updated full_name",
        birth_date: ~D[2025-08-20],
        has_medical_condition: false,
        medical_condition_details: nil,
        image_consent: false,
        belt: "Green"
      }

      assert {:ok, %Ninja{} = ninja} = Ninjas.update_ninja(ninja, update_attrs)
      assert ninja.full_name == "some updated full_name"
      assert ninja.birth_date == ~D[2025-08-20]
      assert ninja.has_medical_condition == false
      assert ninja.medical_condition_details == nil
      assert ninja.image_consent == false
      assert ninja.belt == "Green"
    end

    test "update_ninja/2 with invalid data returns error changeset" do
      ninja = ninja_fixture()
      assert {:error, %Ecto.Changeset{}} = Ninjas.update_ninja(ninja, @invalid_attrs)
      assert ninja == Ninjas.get_ninja!(ninja.id)
    end

    test "delete_ninja/1 deletes the ninja" do
      ninja = ninja_fixture()
      assert {:ok, %Ninja{}} = Ninjas.delete_ninja(ninja)
      assert_raise Ecto.NoResultsError, fn -> Ninjas.get_ninja!(ninja.id) end
    end

    test "change_ninja/1 returns a ninja changeset" do
      ninja = ninja_fixture()
      assert %Ecto.Changeset{} = Ninjas.change_ninja(ninja)
    end
  end
end
