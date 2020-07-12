# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :policr_mini,
  ecto_repos: [PolicrMini.Repo]

# Configures the endpoint
config :policr_mini, PolicrMiniWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wq9hprszCaMJSjc7N5Fn82z6H/mmuRRSFRu8kfgmBYAoUO9WVoGfAw0gOChFYM1d",
  render_errors: [view: PolicrMiniWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PolicrMini.PubSub,
  live_view: [signing_salt: "hy+GpqGC"]

# Configures the image provider
config :policr_mini, PolicrMini.Bot.ImageProvider, path: "images"

# Job schedule
config :policr_mini, PolicrMini.Bot.Scheduler,
  jobs: [
    # 修正过期验证任务
    {"*/5 * * * *", {PolicrMini.Bot.Runner, :fix_expired_wait_status, []}},
    # 检查工作状态任务
    {"*/55 * * * *", {PolicrMini.Bot.Runner, :check_working_status, []}}
  ]

# Configure marked
config :policr_mini,
  marked_enabled: true

# Configures Telegex's timeouts
config :telegex,
  timeout: 1000 * 30,
  recv_timeout: 1000 * 45

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason
# Task global configuration
config :task_after, global_name: TaskAfter

# Internationalization of bot messages
config :exi18n,
  default_locale: "zh-hans",
  locales: ~w(zh-hans),
  fallback: false,
  loader: :yml,
  loader_options: %{path: {:policr_mini, "priv/locales"}},
  var_prefix: "%{",
  var_suffix: "}"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
