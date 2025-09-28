defmodule Katana.Repo.Seeds.Ninjas do
  @moduledoc """
  Seeds Ninjas
  """

  alias Katana.Ninjas.Ninja
  alias Katana.Ninjas
  alias Katana.Repo

  def run do
    case Repo.all(Ninja) do
      [] ->
        seed_ninjas()

      _ ->
        Mix.shell().error("Ninjas found, aborting seeding.")
    end
  end

  defp seed_ninjas do
    ninjas = [
      %{
        full_name: "João Silva",
        birth_date: ~D[2010-03-12],
        has_medical_condition: false,
        medical_condition_details: nil,
        image_consent: true
      },
      %{
        full_name: "Maria Fernandes",
        birth_date: ~D[2009-07-21],
        has_medical_condition: true,
        medical_condition_details: "Allergy to nuts.",
        image_consent: true
      },
      %{
        full_name: "Pedro Costa",
        birth_date: ~D[2011-01-30],
        has_medical_condition: false,
        medical_condition_details: nil,
        image_consent: true
      }
    ]

    for attrs <- ninjas do
      case Ninjas.create_ninja(attrs) do
        {:ok, _ninja} ->
          Mix.shell().info("Created ninja: #{attrs.full_name}")

        {:error, changeset} ->
          Mix.shell().error("Failed to create #{attrs.full_name}: #{inspect(changeset.errors)}")
      end
    end
  end
end

Katana.Repo.Seeds.Ninjas.run()
