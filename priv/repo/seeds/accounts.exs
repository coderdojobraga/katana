defmodule Katana.Repo.Seeds.Accounts do
  @moduledoc """
  Minimal example of seeding.

  NOTE: THIS SEEDING SERVES ONLY AS A EXAMPLE OF STRUCTURE
  """
  alias Katana.Accounts
  alias Katana.Accounts.User
  alias Katana.Repo

  def run do
    case Repo.all(User) do
      [] ->
        seed_users()

      _ ->
        Mix.shell().error("Found users, aborting seeding users.")
    end
  end

  defp seed_users do
    users = [
      %{name: "Chandler Bing", email: "test@mail.com", password: "Pass1234321!"}
    ]

    for attrs <- users do
      case Accounts.register_user(attrs) do
        {:ok, user} ->
          Repo.update!(User.confirm_changeset(user))

        {:error, changeset} ->
          Mix.shell().error(inspect(changeset.errors))
      end
    end
  end
end

Katana.Repo.Seeds.Accounts.run()
