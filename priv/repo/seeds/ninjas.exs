defmodule Katana.Repo.Seeds.Ninjas do
  @moduledoc """
  Seeding de Ninjas
  """

  alias Katana.Ninjas.Ninja
  alias Katana.Ninjas
  alias Katana.Repo

  def run do
    case Repo.all(Ninja) do
      [] ->
        seed_ninjas()

      _ ->
        Mix.shell().error("Encontrados Ninjas, abortando seeding ninjas.")
    end
  end

  defp seed_ninjas do
    ninjas = [
      %{
        full_name: "João Silva",
        birth_date: ~D[2010-03-12],
        has_attended_before: true,
        number_of_sessions: 8,
        coderdojo_experience_description: "Aprendeu conceitos básicos de Scratch e Python.",
        programming_experience_description: "Alguma experiência com programação em blocos.",
        has_medical_condition: false,
        medical_condition_details: nil,
        additional_info: "Adora comer filipinos.",
        image_consent: true,
        belt: "Amarelo"
      },
      %{
        full_name: "Maria Fernandes",
        birth_date: ~D[2009-07-21],
        has_attended_before: false,
        number_of_sessions: 0,
        coderdojo_experience_description: "Primeira vez a participar no dojo.",
        programming_experience_description: "Sem experiência prévia em programação.",
        has_medical_condition: true,
        medical_condition_details: "Alergia a frutos secos.",
        additional_info: nil,
        image_consent: true,
        belt: "Branco"
      },
      %{
        full_name: "Pedro Costa",
        birth_date: ~D[2011-01-30],
        has_attended_before: true,
        number_of_sessions: 5,
        coderdojo_experience_description: "Aprendeu Scratch e básicos de Python.",
        programming_experience_description: "Experimentou Javascript em projetos escolares.",
        has_medical_condition: false,
        medical_condition_details: nil,
        additional_info: "Gosta de criar jogos simples.",
        image_consent: true,
        belt: "Verde"
      }
    ]

    for attrs <- ninjas do
      case Ninjas.create_ninja(attrs) do
        {:ok, _ninja} ->
          Mix.shell().info("Criado ninja: #{attrs.full_name}")

        {:error, changeset} ->
          Mix.shell().error("Erro ao criar #{attrs.full_name}: #{inspect(changeset.errors)}")
      end
    end
  end
end

Katana.Repo.Seeds.Ninjas.run()
