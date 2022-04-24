# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :pay_station,
  ecto_repos: [PayStation.Repo]

# Configures the endpoint
config :pay_station, PayStationWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: PayStationWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: PayStation.PubSub,
  live_view: [signing_salt: "ajY/5dvz"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :kaffe,
  consumer: [
    endpoints: [localhost: 9092],
    topics: ["transactions_created"],
    consumer_group: "pay-station-transaction-created-group",
    message_handler: PayStation.Expenses.ExpensesProcessor,
    offset_reset_policy: :reset_to_latest,
    max_bytes: 500_000,
    worker_allocation_strategy: :worker_per_topic_partition,
  ],
  producer: [
    endpoints: [localhost: 9092],
    topics: ["transactions_created"]
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
