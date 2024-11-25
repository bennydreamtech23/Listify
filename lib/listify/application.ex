defmodule Listify.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ListifyWeb.Telemetry,
      Listify.Repo,
      {DNSCluster, query: Application.get_env(:listify, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Listify.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Listify.Finch},
      # Start a worker by calling: Listify.Worker.start_link(arg)
      # {Listify.Worker, arg},
      # Start to serve requests, typically the last entry
      ListifyWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Listify.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ListifyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
