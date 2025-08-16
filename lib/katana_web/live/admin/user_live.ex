defmodule KatanaWeb.Live.UserLive do
  use Backpex.LiveResource,
    adapter_config: [
      schema: Katana.Accounts.User,
      repo: Katana.Repo,
      update_changeset: &Katana.Accounts.User.update_changeset/3,
      create_changeset: &Katana.Accounts.User.registration_changeset/3    ],
    layout: {KatanaWeb.Layouts, :admin}

  @impl Backpex.LiveResource
  def singular_name, do: "User"

  @impl Backpex.LiveResource
  def plural_name, do: "Users"

  @impl Backpex.LiveResource
  def fields do
    [
      title: %{
        module: Backpex.Fields.Text,
        label: "Name"
      },
      views: %{
        module: Backpex.Fields.Text,
        label: "Password"
      }
    ]
  end
end
