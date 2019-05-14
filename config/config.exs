# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :banking,
  ecto_repos: [Banking.Repo]

# Configures the endpoint
config :banking, BankingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MGsJNkpGzG9WS5ogLxysDt8TwXC6UHpjCVf94M18vo9Sn6PBhX11V88ltXjAPwOl",
  render_errors: [view: BankingWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Banking.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configures Guardian
config :banking, Banking.Guardian,
  issuer: "banking",
  ttl: {1, :days},
  token_ttl: %{
    "refresh" => {30, :days},
    "access" => {1, :days}
  },
  secret_key: "6kBnoqWblPSTn7Ms9MOEqtp80KB908uysc0LjLc0ZUTlHlIVly2iMf0enhi4WKZh"
