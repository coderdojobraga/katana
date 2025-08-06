defmodule KatanaWeb.UserLoginLive do
  use KatanaWeb, {:live_view, :root}

  def render(assigns) do
    ~H"""
    <.vue v-component="UserLogin" />
    """
  end

  def mount(_params, _session, socket) do
    email = Phoenix.Flash.get(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end
end
