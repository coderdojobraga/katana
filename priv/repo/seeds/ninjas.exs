defmodule Katana.Repo.Seeds.Ninjas do
  @moduledoc """
  Seeding of Ninjas
  """

  alias Faker.{Person.PtBr, Lorem}
  alias Katana.Ninjas.Ninja
  alias Katana.Ninjas
  alias Katana.Repo

  @belts ["white", "yellow", "blue", "green", "orange", "red", "purple", "black"]

  def run do
    case Repo.all(Ninja) do
      [] -> seed_ninjas()
      _ -> Mix.shell().error("Found ninjas, aborting seeding ninjas.")
    end
  end

  defp seed_ninjas do
    ninjas =
      for _ <- 1..100 do
        {has_medical_condition, medical_condition_details} = medical_condition()

        %{
          full_name: build_name(),
          birth_date: random_date(),
          has_medical_condition: has_medical_condition,
          medical_condition_details: medical_condition_details,
          image_consent: random_bool(),
          belt: Enum.random(@belts)
        }
      end

    for attrs <- ninjas do
      case Ninjas.create_ninja(attrs) do
        {:ok, _ninja} ->
          Mix.shell().info("Created ninja #{attrs.full_name}")

        {:error, changeset} ->
          Mix.shell().error("Failed to create ninja #{attrs.full_name}: #{inspect(changeset.errors)}")
      end
    end
  end

  defp build_name do
    firsts =
      1..Enum.random(1..2)
      |> Enum.map(fn _ -> PtBr.first_name() end)
      |> Enum.join(" ")

    lasts =
      1..Enum.random(2..3)
      |> Enum.map(fn _ -> PtBr.last_name() end)
      |> Enum.join(" ")

    "#{firsts} #{lasts}"
  end

  defp random_date do
    year = Enum.random(2008..2015)
    month = Enum.random(1..12)
    day = Enum.random(1..28)
    {_, date} = Date.new(year, month, day)
    date
  end

  defp medical_condition do
    if random_bool() do
      {true, Lorem.sentence()}
    else
      {false, nil}
    end
  end

  defp random_bool, do: Enum.random([true, false])
end

Katana.Repo.Seeds.Ninjas.run()
