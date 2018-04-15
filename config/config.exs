# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :tod,
  namespace: TOD

# Configures the endpoint
config :tod, TODWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "b9OXpdZD83PuIPo8ze91Kuhq2+bIFV+gJ335JwTiQ5krDfLVizHBuQj32pWa/Vl/",
  render_errors: [view: TODWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TOD.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
