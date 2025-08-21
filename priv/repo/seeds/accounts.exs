defmodule Katana.Repo.Seeds.Accounts do
  alias Faker.Person.PtBr
  alias Katana.{Repo, Accounts}
  alias Katana.Accounts.User
  alias Katana.Guardians.Guardian

  def run do
    case Repo.all(User) do
      [] -> seed_accounts()
      _ -> Mix.shell().error("Found users, aborting seeding users.")
    end
  end

  defp seed_accounts do
    seed_guardians()
  end

  defp seed_guardians do
    guardians = Repo.all(Guardian)

    case guardians do
      [] ->
        Mix.shell().error("No guardians found. Please seed guardians first.")

      _ ->

        for {guardian, idx} <- Enum.with_index(guardians, 1) do
          create_user(%{
            name: build_name(),
            email: "guardian#{idx}@gmail.com",
            password: "Pass1234321!",
            guardian_id: guardian.id
          }, "guardian", idx)
        end
    end
  end


  defp create_user(attrs, type, id) do
    case Accounts.register_user(attrs) do
      {:ok, user} ->
      Mix.shell().info("Created #{type} #{user.name} (#{attrs.email})")
      {:error, changeset} ->
        Mix.shell().error("Error creating #{type} #{id}: " <> Kernel.inspect(changeset.errors))
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
end

Katana.Repo.Seeds.Accounts.run()
