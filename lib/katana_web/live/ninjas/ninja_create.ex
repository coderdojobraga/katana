defmodule KatanaWeb.NinjasCreateLive do
  use KatanaWeb, {:live_view, :root}


  def render(assigns) do
    ~H"""
    <.vue v-component="CreateForm" />
    """
  end
end
