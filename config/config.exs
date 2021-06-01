# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :gitex,
  ecto_repos: [Gitex.Repo],
  generators: [binary_id: true]

config :gitex, Gitex.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Configures the endpoint
config :gitex, GitexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xJ8Jr6MbLXqrra7Nlc7F3lOGvLbyenz1eJRYU2Vp0T1UHxQGxTwF0MHtun6kdIAE",
  render_errors: [view: GitexWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Gitex.PubSub,
  live_view: [signing_salt: "Lj9I1gNh"]

config :gitex, GitexWeb.Auth.Guardian,
  issuer: "gitex",
  secret_key: "KX9hqeM2SD4YraljborE+S9JXff+ifjx4i7I/Ubd1bx9uap/gAqW1whWoRG4nZ+Q"

config :gitex, GitexWeb.Auth.Pipeline,
  module: GitexWeb.Auth.Guardian,
  error_handler: GitexWeb.Auth.ErrorHandler

config :gitex, GitexWeb.GithubController, github_adapter: Gitex.Github.Client

config :tesla, adapter: Tesla.Adapter.Hackney

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
