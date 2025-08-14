defmodule KatanaWeb.UserResetPasswordLive do
  use KatanaWeb, {:live_view, :root}

  alias Katana.Accounts

  def render(assigns) do
    ~H"""
    <.vue v-component="UserResetPassword" form={@form} v-socket={@socket} />
    """
  end

  def mount(params, _session, socket) do
    socket = assign_user_and_token(socket, params)

    source =
      case socket.assigns do
        %{user: user} ->
          Accounts.change_user_password(user)

        _ ->
          %{}
      end

    form = to_form(source, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: nil]}
  end

  def handle_event("validate", %{"user" => params}, socket) do
    changeset =
      Accounts.change_user_password(socket.assigns.user, params)
      |> Map.put(:action, :validate)

    {:noreply, reload(socket, changeset)}
  end

  # Do not log in the user after reset password to avoid a
  # leaked token giving the user access to the account.
  def handle_event("reset_password", %{"user" => params}, socket) do
    case Accounts.reset_user_password(socket.assigns.user, params) do
      {:ok, _} ->
        {:noreply,
         socket
         |> put_flash(:info, "Password reset successfully. Please proceed to log in.")
         |> redirect(to: ~p"/users/log_in")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply,
         socket
         |> put_flash(
           :error,
           "Password reset failed. Please try again and if the problem persists, contact support."
         )
         |> reload(Map.put(changeset, :action, :insert))}
    end
  end

  defp assign_user_and_token(socket, %{"token" => token}) do
    if user = Accounts.get_user_by_reset_password_token(token) do
      assign(socket, user: user, token: token)
    else
      socket
      |> put_flash(:error, "Reset password link is invalid or it has expired.")
      |> redirect(to: ~p"/")
    end
  end

  defp reload(socket, changeset) do
    form = to_form(changeset, as: "user")
    assign(socket, form: form)
  end
end
