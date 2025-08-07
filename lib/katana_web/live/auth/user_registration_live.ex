defmodule KatanaWeb.UserRegistrationLive do
  use KatanaWeb, {:live_view, :root}

  alias Katana.Accounts
  alias Katana.Accounts.User

  def render(assigns) do
    ~H"""
    <.vue v-component="UserRegistration" form={@form} v-socket={@socket} />
    """
  end

  def mount(_params, _session, socket) do
    form = Accounts.change_user_registration(%User{}) |> to_form(as: "user")
    {:ok, assign(socket, form: form, temporary_assigns: [form: nil])}
  end

  def handle_event("validate", %{"user" => params}, socket) do
    changeset =
      Accounts.change_user_registration(%User{}, params)
      |> Map.put(:action, :validate)

    {:noreply, reload(socket, changeset)}
  end

  def handle_event("save", %{"user" => params}, socket) do
    case Accounts.register_user(params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &url(~p"/users/confirm/#{&1}")
          )

        {:noreply,
         socket
         |> put_flash(
           :info,
           "An email was sent to #{user.email}, please access it to confirm your account."
         )
         |> push_navigate(to: ~p"/users/log_in")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply,
         socket
         |> put_flash(
           :error,
           "Registration failed. Please try again and if the problem persists, contact support."
         )
         |> reload(changeset)}
    end
  end

  defp reload(socket, changeset) do
    form = to_form(changeset, as: "user")
    assign(socket, form: form)
  end
end
