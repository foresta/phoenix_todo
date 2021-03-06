# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :phoenix_todo,
  ecto_repos: [PhoenixTodo.Repo]

# Configures the endpoint
config :phoenix_todo, PhoenixTodo.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WOXwpjc7PAFh7/JLbm9kwKB9poFUdGdLOyEHHyOmD08ZphM4AOrsAJtNReZheIuW",
  render_errors: [view: PhoenixTodo.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhoenixTodo.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :guardian, Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "PhoenixTodo",
  ttl: { 30, :days},
  verify_issuer: true,
  secret_key: "asdfghjkl;",
  serializer: PhoenixTodo.GuardianSerializer
