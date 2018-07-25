# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :discuss,
  ecto_repos: [Discuss.Repo]

# Configures the endpoint
config :discuss, DiscussWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ulELvlbas4j5ua+e5uPG3zbMWh+9+zYamf43LngKbWzJz+/e98HZ5pYZJDebgF+7",
  render_errors: [view: DiscussWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Discuss.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

#authentication praragraph
config :ueberauth, Ueberauth,
    providers: [
        github: { Ueberauth.Strategy.Github, [default_scope: "user,public_repo"] } # [info] - is temporary
    ]
#
config :ueberauth, Ueberauth.Strategy.Github.OAuth,
    client_id: "de40a9bd858308689c13",
    client_secret: "a99b5c539c7721eb79d6bbeb07a62c50d41e1b8f"
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
