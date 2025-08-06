defmodule KatanaWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, components, channels, and so on.

  This can be used in your application as:

      use KatanaWeb, :controller
      use KatanaWeb, :html

  The definitions below will be executed for every controller,
  component, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define additional modules and import
  those modules here.
  """

  def static_paths, do: ~w(assets fonts images favicon.ico robots.txt)

  def router do
    quote do
      use Phoenix.Router, helpers: false

      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
    end
  end

  def controller do
    quote do
      use Phoenix.Controller,
        formats: [:html],
        layouts: [html: KatanaWeb.Layouts]

      use Gettext, backend: KatanaWeb.Gettext

      import Plug.Conn

      unquote(verified_routes())
    end
  end

  def live_view(layout) do
    layout_opts = if layout, do: [layout: {KatanaWeb.Layouts, layout}], else: []

    quote do
      use Phoenix.LiveView, unquote(layout_opts)

      unquote(html_helpers())
    end
  end

  def live_view do
    quote do
      use Phoenix.LiveView, layout: {KatanaWeb.Layouts, :app}

      unquote(html_helpers())
    end
  end

  def component do
    quote do
      use Phoenix.Component

      alias Phoenix.LiveView.JS

      def show(js \\ %JS{}, selector) do
        JS.show(js,
          to: selector,
          time: 300,
          transition:
            {"transition-all transform ease-out duration-300",
            "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95",
            "opacity-100 translate-y-0 sm:scale-100"}
        )
      end

      def hide(js \\ %JS{}, selector) do
        JS.hide(js,
          to: selector,
          time: 200,
          transition:
            {"transition-all transform ease-in duration-200",
            "opacity-100 translate-y-0 sm:scale-100",
            "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"}
        )
      end
    end
  end

  def live_component do
    quote do
      use Phoenix.LiveComponent

      unquote(html_helpers())
    end
  end

  def html do
    quote do
      use Phoenix.Component

      import Phoenix.Controller,
        only: [get_csrf_token: 0, view_module: 1, view_template: 1]

      unquote(html_helpers())
    end
  end

  defp html_helpers do
    quote do
      use Gettext, backend: KatanaWeb.Gettext
      use LiveVue

      use LiveVue.Components,
        vue_root: [
          "./assets/vue",
          "./lib/katana_web"
        ]

      import Phoenix.HTML
      import KatanaWeb.CoreComponents.{
        Flash,
        FlashGroup,
        Icon
      }

      alias Phoenix.LiveView.JS

      # Routes generation with the ~p sigil
      unquote(verified_routes())
    end
  end

  def verified_routes do
    quote do
      use Phoenix.VerifiedRoutes,
        endpoint: KatanaWeb.Endpoint,
        router: KatanaWeb.Router,
        statics: KatanaWeb.static_paths()
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/live_view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end

  defmacro __using__({which, layout}) when is_atom(which) do
    apply(__MODULE__, which, [layout])
  end
end
