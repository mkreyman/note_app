import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :note_app, NoteAppWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "MckrrGiZjdYw4sW0lUn6y3/2gebZpmxgj7xHpoGnnEKcNbxMYLYSFbS82LiP+jld",
  server: false

# In test we don't send emails.
config :note_app, NoteApp.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :note_app, NoteApp.Repo,
  username: "postgres",
  password: "Cran8Gat8",
  hostname: "localhost",
  database: "note_app_test#{System.get_env("MIX_TEST_PARTITION")}",
  port: 5433,
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10
