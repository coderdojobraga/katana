defmodule Katana.Repo.Seeds.GuardiansNinjas do
  @moduledoc """
  Seeding of guardian_ninja join table.
  """
  import Ecto.Query, only: [from: 2]   # <-- needed for `from(gn in GuardianNinja, ...)`

  alias Katana.Repo
  alias Katana.Ninjas.Ninja
  alias Katana.Guardians.Guardian
  alias Katana.GuardiansNinjas.GuardianNinja

  def run do
    ninjas = Repo.all(Ninja)
    guardians = Repo.all(Guardian)

    cond do
      ninjas == [] ->
        Mix.shell().error("No Ninjas found, aborting seeding.")

      guardians == [] ->
        Mix.shell().error("No Guardians found, aborting seeding.")

      true ->
        seed_guardian_ninjas(ninjas, guardians)
    end
  end

  defp seed_guardian_ninjas(ninjas, guardians) do
    shuffled_guardians = Enum.shuffle(guardians)

    Enum.each(ninjas, fn ninja ->
      num_guardians = Enum.random(1..2)

      available_guardians =
        shuffled_guardians
        |> Enum.filter(fn g ->
          count =
            Repo.aggregate(
              from(gn in GuardianNinja, where: gn.guardian_id == ^g.id),
              :count,
              :id
            )

          count < 3
        end)
        |> Enum.shuffle()

      guardians_to_link = Enum.take(available_guardians, num_guardians)

      Enum.each(guardians_to_link, fn guardian ->
        case Katana.GuardiansNinjas.create_guardian_ninja(%{
          ninja_id: ninja.id,
          guardian_id: guardian.id
        }) do
          {:ok, _record} ->
            :ok

          {:error, changeset} ->
            Mix.shell().error("Failed to create GuardianNinja: #{inspect(changeset.errors)}")
        end
      end)

    end)

    Mix.shell().info("Done! Each Ninja has 1–2 Guardians, each Guardian has 0–3 Ninjas.")
  end
end

Katana.Repo.Seeds.GuardiansNinjas.run()
