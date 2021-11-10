## This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :grain_web,
  ecto_repos: [Grain.Repo],
  generators: [context_app: :grain]

# Configures the endpoint
config :grain_web, GrainWeb.Endpoint,
  url: [host: "grain.gigalixirapp.com"],
  secret_key_base: "J1yC9GgAwF/xY/ql9RVS8JNvE2Ggq4d8hrVhcumk9mFl4KrAXtOpQ4Au6GA+T6fq",
  render_errors: [view: GrainWeb.ErrorView, accepts: ~w(html json), layout: false],
  # pubsub: [name: GrainWeb.PubSub, adapter: Phoenix.PubSub.PG2]
  pubsub_server: Grain.PubSub,
  live_view: [signing_salt: "wTpJJ7JP"]

# Import environment specific config. This must remain at the bottom
# of thisname file so it overrides the configuration defined above.
# config :new_relic_agent,
# app_name: "Grain",
# license_key: "ee9c2eabf9a8054364cfc885b768dc549c1ee5c6"

{:ok, pid} = Agent.start_link(fn -> %{} end)

config :grain,
  ecto_repos: [Grain.Repo]

defmodule Cc do
  def z(pid) do
    case Date.day_of_week(DateTime.utc_now()) do
      x when x in [6, 7] ->
        nil

      _ ->
        Grain.Tasks.run(pid)
    end
  end
end

config :grain, Grain.Scheduler,
  jobs: [
    {{:extended, "5 0-59/1 0-8/1 * *"}, {Cc, :z, [pid]}},
    # {Grain.Tasks, :run, [pid]}},
    # {{:extended, "10 * * * *"}, {Grain.Tasks, :run, [pid]}},
    # {"* * * * *", {Grain.Tasks, :run, [pid]}}
    {"32 7 * * *", {Grain.Task, :grain_delete, []}}
    # {"30/30 0-3/1 * * *", {Grain.Tasks, :run, [pid]}}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.

# config :new_relic_agent,
# app_name: "Grain App",
# license_key: "ee9c2eabf9a8054364cfc885b768dc549c1ee5c6"

import_config "#{Mix.env()}.exs"
