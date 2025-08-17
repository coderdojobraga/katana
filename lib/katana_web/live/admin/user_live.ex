defmodule KatanaWeb.UserLive do
  use Backpex.LiveResource,
    adapter_config: [
      schema: Katana.Accounts.User,
      repo: Katana.Repo,
      update_changeset: &Katana.Accounts.User.update_changeset/3,
      create_changeset: &Katana.Accounts.User.registration_changeset/3
    ],
    layout: {KatanaWeb.Layouts, :admin}

  @impl Backpex.LiveResource
  def singular_name, do: "User"

  @impl Backpex.LiveResource
  def plural_name, do: "Users"

  @impl Backpex.LiveResource
  def fields do
    [
      name: %{
        module: Backpex.Fields.Text,
        label: "Name",
        placeholder: "Enter full name"
      },
      email: %{
        module: Backpex.Fields.Text,
        label: "Email",
        placeholder: "Enter email address"
      },
      password: %{
        module: Backpex.Fields.Text,
        label: "Password",
        placeholder: "Enter password"
      },
      current_password: %{
        module: Backpex.Fields.Text,
        label: "Current Password",
        placeholder: "Enter current password if updating"
      }
    ]
  end
end
