defmodule KatanaWeb.UserLoginLive do
  use KatanaWeb, {:live_view, :root}

  alias Katana.Accounts
  alias KatanaWeb.UserAuth

  def render(assigns) do
    ~H"""
    <.vue v-component="UserLogin" />
    """
  end

  def mount(_params, _session, socket) do
    form = to_form(%{}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end

  def handle_event("submit", %{"user" => params}, socket) do
    %{"email" => email, "password" => password} = params

    if user = Accounts.get_user_by_email_and_password(email, password) do
      {:noreply,
       socket
       |> put_flash(:info, "Welcome back!")
       |> UserAuth.log_in_user(user, params)}
    else
      # In order to prevent user enumeration attacks, don't disclose whether the email is registered.
      {:noreply,
       socket
       |> put_flash(:error, "Invalid email or password. Please try again shortly.")
       |> reload()}
    end
  end

  defp reload(socket) do
    form = to_form(%{}, as: "user")
    assign(socket, form: form)
  end
end
