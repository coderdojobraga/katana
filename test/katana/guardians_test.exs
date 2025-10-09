defmodule Katana.GuardiansTest do
  use Katana.DataCase

  alias Katana.Guardians

  describe "guardians" do
    alias Katana.Guardians.Guardian

    import Katana.GuardiansFixtures

    @invalid_attrs %{phone: nil}

    test "list_guardians/0 returns all guardians" do
      guardian = guardian_fixture()
      assert Guardians.list_guardians() == [guardian]
    end

    test "get_guardian!/1 returns the guardian with given id" do
      guardian = guardian_fixture()
      assert Guardians.get_guardian!(guardian.id) == guardian
    end

    test "create_guardian/1 with valid data creates a guardian" do
      valid_attrs = %{phone: "some phone"}

      assert {:ok, %Guardian{} = guardian} = Guardians.create_guardian(valid_attrs)
      assert guardian.phone == "some phone"
    end

    test "create_guardian/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Guardians.create_guardian(@invalid_attrs)
    end

    test "update_guardian/2 with valid data updates the guardian" do
      guardian = guardian_fixture()
      update_attrs = %{phone: "some updated phone"}

      assert {:ok, %Guardian{} = guardian} = Guardians.update_guardian(guardian, update_attrs)
      assert guardian.phone == "some updated phone"
    end

    test "update_guardian/2 with invalid data returns error changeset" do
      guardian = guardian_fixture()
      assert {:error, %Ecto.Changeset{}} = Guardians.update_guardian(guardian, @invalid_attrs)
      assert guardian == Guardians.get_guardian!(guardian.id)
    end

    test "delete_guardian/1 deletes the guardian" do
      guardian = guardian_fixture()
      assert {:ok, %Guardian{}} = Guardians.delete_guardian(guardian)
      assert_raise Ecto.NoResultsError, fn -> Guardians.get_guardian!(guardian.id) end
    end

    test "change_guardian/1 returns a guardian changeset" do
      guardian = guardian_fixture()
      assert %Ecto.Changeset{} = Guardians.change_guardian(guardian)
    end
  end
end
