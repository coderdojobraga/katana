defmodule KatanaWeb.NinjasCreateLive do
  use KatanaWeb, {:live_view, :root}

  alias Katana.Ninjas

  def render(assigns) do
    ~H"""
    <.vue v-component="CreateForm" />
    """
  end
end
