defmodule KatanaWeb.UserForgotPasswordLive do
  use KatanaWeb, {:live_view, :root}

  alias Katana.Accounts

  def render(assigns) do
    ~H"""
    <.vue v-component="UserForgotPassword" v-socket={@socket} />
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{}, as: "user"))}
  end

  def handle_event("send_email", %{"user" => %{"email" => email}}, socket) do
    if user = Accounts.get_user_by_email(email) do
      Accounts.deliver_user_reset_password_instructions(
        user,
        &url(~p"/users/reset_password/#{&1}")
      )
    end

    {:noreply,
     socket
     |> put_flash(
       :info,
       "If your email is in our system, you will receive instructions to reset your password shortly."
     )
     |> redirect(to: ~p"/")}
  end
end
