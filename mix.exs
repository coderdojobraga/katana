defmodule Katana.MixProject do
  use Mix.Project

  @app :katana
  @version "0.1.0"

  def project do
    [
      app: @app,
      version: @version,
      elixir: "~> 1.18",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Katana.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # core
      {:live_vue, git: "https://github.com/Valian/live_vue.git", branch: "useLiveForm"},
      {:bandit, "~> 1.5"},
      {:phoenix, "~> 1.7.21"},
      {:phoenix_live_view, "~> 1.0"},
      {:phoenix_html, "~> 4.1"},
      {:jason, "~> 1.2"},
      {:dns_cluster, "~> 0.1.1"},

      # database
      {:phoenix_ecto, "~> 4.5"},
      {:ecto_sql, "~> 3.10"},
      {:postgrex, ">= 0.0.0"},

      # auth
      {:argon2_elixir, "~> 3.0"},

      # frontend
      {:lucide,
       github: "lucide-icons/lucide",
       tag: "0.536.0",
       sparse: "icons",
       app: false,
       compile: false,
       depth: 1},

      # mailer
      {:swoosh, "~> 1.5"},
      {:finch, "~> 0.13"},

      # telemetry
      {:phoenix_live_dashboard, "~> 0.8.3"},
      {:telemetry_metrics, "~> 1.0"},
      {:telemetry_poller, "~> 1.0"},

      # test
      {:floki, ">= 0.30.0", only: :test},

      # i18n
      {:gettext, "~> 0.26"},

      # dev
      {:igniter, "~> 0.6", only: [:dev, :test]},
      {:phoenix_live_reload, "~> 1.2", only: :dev}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "assets.setup", "assets.build"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "format.all": ["format", "cmd --cd assets npm run format"],
      "assets.setup": ["cmd --cd assets npm install"],
      "assets.build": [
        "cmd --cd assets npm run build",
        "cmd --cd assets npm run build-server"
      ],
      "assets.deploy": [
        "cmd --cd assets npm run build",
        "cmd --cd assets npm run build-server",
        "phx.digest"
      ]
    ]
  end
end
