import Config

# Configure your database
config :family_foundations, FamilyFoundations.Repo,
  url: System.get_env("DATABASE_URL"),
  ssl: [verify: :verify_none],
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# Configure the Endpoint (Web Server)
config :family_foundations, FamilyFoundationsWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4001],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "nWNbwnMTLmaI82HttzwJU1fPj/sohYvba6qofZVwPQQy9hTenfjDJnP2tOk9LsBb",
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:family_foundations, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:family_foundations, ~w(--watch)]}
  ]

# Configure LiveReload
config :family_foundations, FamilyFoundationsWeb.Endpoint,
  live_reload: [
    web_console_logger: true,
    patterns: [
      ~r"priv/static/(?!uploads/).*\.(js|css|png|jpeg|jpg|gif|svg)$"E,
      ~r"priv/gettext/.*\.po$"E,
      ~r"lib/family_foundations_web/router\.ex$"E,
      ~r"lib/family_foundations_web/(controllers|live|components)/.*\.(ex|heex)$"E
    ]
  ]

# Enable dev routes for dashboard and mailbox
config :family_foundations, dev_routes: true

# Do not include metadata nor timestamps in development logs
config :logger, :default_formatter, format: "[$level] $message\n"

# Set a higher stacktrace during development
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

# Configure LiveView
config :phoenix_live_view,
  debug_heex_annotations: true,
  debug_attributes: true,
  enable_expensive_runtime_checks: true

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false
