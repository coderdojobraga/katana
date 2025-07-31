defmodule KatanaWeb.HomeLive.Index do
  @moduledoc false

  use KatanaWeb, :live_view

  def mount(_params, _, socket) do
    {:ok, assign(socket, count: 0)}
  end

  def render(assigns) do
    ~H"""
    <.Counter count={@count} v-socket={@socket} v-ssr={true} v-on:inc={JS.push("inc")} />
    """
  end

  def handle_event("inc", %{"value" => diff}, socket) do
    current = socket.assigns.count
    {:noreply, assign(socket, count: current + diff)}
  end
end
