defmodule Katana.Repo.Seeds.Guardians do
  @moduledoc """
  Seeding de Guardians (50 gerados com Faker.Phone.PtPt)

  NOTE: THIS SEEDING SERVES ONLY AS A STRUCTURAL EXAMPLE
  """
  alias Katana.Guardians
  alias Katana.Guardians.Guardian
  alias Katana.Repo
  alias Faker.Phone.PtPt

  def run do
    case Repo.all(Guardian) do
      [] ->
        seed_guardians()

      _ ->
        Mix.shell().error("Found guardians, aborting seeding guardians.")
    end
  end

  defp seed_guardians do
    guardians =
      for _ <- 1..50 do
        %{
          phone: PtPt.cell_number()
        }
      end

    for attrs <- guardians do
      case Guardians.create_guardian(attrs) do
        {:ok, guardian} ->
          Mix.shell().info("Created guardian! phone: #{guardian.phone}")

        {:error, changeset} ->
          Mix.shell().error(inspect(changeset.errors))
      end
    end
  end
end

Katana.Repo.Seeds.Guardians.run()
