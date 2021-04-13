defmodule AsimovApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      AsimovApi.Repo,
      # Start the Telemetry supervisor
      AsimovApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: AsimovApi.PubSub},
      # Start the Endpoint (http/https)
      AsimovApiWeb.Endpoint
      # Start a worker by calling: AsimovApi.Worker.start_link(arg)
      # {AsimovApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AsimovApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    AsimovApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
