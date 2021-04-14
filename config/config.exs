# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :asimov_api,
  ecto_repos: [AsimovApi.Repo]

# Configures the endpoint
config :asimov_api, AsimovApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CZeZglvUC5F99QKxfXnuxLwl16bYmaz5rlZiNjB/dd1q/i1Y5zB/q1tdNHejmMmp",
  render_errors: [view: AsimovApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: AsimovApi.PubSub,
  live_view: [signing_salt: "kEArTgLy"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason
config :phoenix_swagger, json_library: Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :asimov_api, AsimovApiWeb.Auth.Guardian,
  issuer: "asimov_api",
  secret_key: "70am0IHk8GQ8dfYOFfnY+5gxa2Ucj37uGlL5Al8zW+TzcoCl+wfboDZ3BC1pcJHx"

config :asimov_api, AsimovApiWeb.Auth.Pipeline,
  module: AsimovApiWeb.Auth.Guardian,
  error_handler: AsimovApiWeb.Auth.ErrorHandler

config :asimov_api, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      router: AsimovApiWeb.Router,
      endpoint: AsimovApiWeb.Endpoint
    ]
  }
