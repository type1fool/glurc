# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :glurc, GlurcWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4SGIgpOAJimHvWasaOQUrpEQHaJ8n+XMuP0W0xn+5Ii4KMxEUJI1Gx6rRgST15Xw",
  render_errors: [view: GlurcWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Glurc.PubSub,
  live_view: [signing_salt: "XHqG1uGF"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"