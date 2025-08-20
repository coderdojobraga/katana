defmodule Katana.NinjasTest do
  use Katana.DataCase

  alias Katana.Ninjas

  describe "ninjas" do
    alias Katana.Ninjas.Ninja

    import Katana.NinjasFixtures

    @invalid_attrs %{full_name: nil, birth_date: nil, has_attended_before: nil, number_of_sessions: nil, coderdojo_experience_description: nil, programming_experience_description: nil, has_medical_condition: nil, medical_condition_details: nil, additional_info: nil, image_consent: nil, belt: nil}

    test "list_ninjas/0 returns all ninjas" do
      ninja = ninja_fixture()
      assert Ninjas.list_ninjas() == [ninja]
    end

    test "get_ninja!/1 returns the ninja with given id" do
      ninja = ninja_fixture()
      assert Ninjas.get_ninja!(ninja.id) == ninja
    end

    test "create_ninja/1 with valid data creates a ninja" do
      valid_attrs = %{full_name: "some full_name", birth_date: ~D[2025-08-19], has_attended_before: true, number_of_sessions: 42, coderdojo_experience_description: "some coderdojo_experience_description", programming_experience_description: "some programming_experience_description", has_medical_condition: true, medical_condition_details: "some medical_condition_details", additional_info: "some additional_info", image_consent: true, belt: "some belt"}

      assert {:ok, %Ninja{} = ninja} = Ninjas.create_ninja(valid_attrs)
      assert ninja.full_name == "some full_name"
      assert ninja.birth_date == ~D[2025-08-19]
      assert ninja.has_attended_before == true
      assert ninja.number_of_sessions == 42
      assert ninja.coderdojo_experience_description == "some coderdojo_experience_description"
      assert ninja.programming_experience_description == "some programming_experience_description"
      assert ninja.has_medical_condition == true
      assert ninja.medical_condition_details == "some medical_condition_details"
      assert ninja.additional_info == "some additional_info"
      assert ninja.image_consent == true
      assert ninja.belt == "some belt"
    end

    test "create_ninja/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ninjas.create_ninja(@invalid_attrs)
    end

    test "update_ninja/2 with valid data updates the ninja" do
      ninja = ninja_fixture()
      update_attrs = %{full_name: "some updated full_name", birth_date: ~D[2025-08-20], has_attended_before: false, number_of_sessions: 43, coderdojo_experience_description: "some updated coderdojo_experience_description", programming_experience_description: "some updated programming_experience_description", has_medical_condition: false, medical_condition_details: "some updated medical_condition_details", additional_info: "some updated additional_info", image_consent: false, belt: "some updated belt"}

      assert {:ok, %Ninja{} = ninja} = Ninjas.update_ninja(ninja, update_attrs)
      assert ninja.full_name == "some updated full_name"
      assert ninja.birth_date == ~D[2025-08-20]
      assert ninja.has_attended_before == false
      assert ninja.number_of_sessions == 43
      assert ninja.coderdojo_experience_description == "some updated coderdojo_experience_description"
      assert ninja.programming_experience_description == "some updated programming_experience_description"
      assert ninja.has_medical_condition == false
      assert ninja.medical_condition_details == "some updated medical_condition_details"
      assert ninja.additional_info == "some updated additional_info"
      assert ninja.image_consent == false
      assert ninja.belt == "some updated belt"
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
