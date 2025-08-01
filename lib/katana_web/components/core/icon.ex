defmodule KatanaWeb.CoreComponents.Icon do
  use Phoenix.Component

  @doc """
  Renders a [Lucide icon](https://lucide.dev/icons).

  ## Examples

      <.icon name="lucide-x" />
      <.icon name="lucide-move-right" class="ml-1 w-3 h-3 animate-spin" />
  """
  attr :name, :string, required: true
  attr :class, :string, default: nil

  def icon(%{name: "lucide-" <> _} = assigns) do
    ~H"""
    <span class={[@name, @class]} />
    """
  end
end
