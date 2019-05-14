use Mix.Config

# Configure your database
config :banking, Banking.Repo,
  username: "postgres",
  password: "postgres",
  database: "banking_test",
  hostname: System.get_env("DATABASE_URL"),
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :banking, BankingWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
