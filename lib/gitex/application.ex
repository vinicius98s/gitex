defmodule Gitex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Gitex.Repo,
      # Start the Telemetry supervisor
      GitexWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Gitex.PubSub},
      # Start the Endpoint (http/https)
      GitexWeb.Endpoint
      # Start a worker by calling: Gitex.Worker.start_link(arg)
      # {Gitex.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gitex.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    GitexWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
