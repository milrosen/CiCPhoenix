defmodule CicFrontend.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CicFrontendWeb.Telemetry,
      CicFrontend.Repo,
      {DNSCluster, query: Application.get_env(:cic_frontend, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: CicFrontend.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: CicFrontend.Finch},
      # Start a worker by calling: CicFrontend.Worker.start_link(arg)
      # {CicFrontend.Worker, arg},
      # Start to serve requests, typically the last entry
      CicFrontendWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CicFrontend.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CicFrontendWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
