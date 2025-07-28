defmodule Katana.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      KatanaWeb.Telemetry,
      Katana.Repo,
      {DNSCluster, query: Application.get_env(:katana, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Katana.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Katana.Finch},
      # Start a worker by calling: Katana.Worker.start_link(arg)
      # {Katana.Worker, arg},
      # Start to serve requests, typically the last entry
      KatanaWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Katana.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    KatanaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
