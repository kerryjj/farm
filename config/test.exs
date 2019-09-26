use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :farm, FarmWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
#config :farm, Farm.Repo,
#       username: "postgres",
#       password: "postgres",
#       database: "farm_test",
#       hostname: "localhost",
#       pool: Ecto.Adapters.SQL.Sandbox

config :farm, Farm.Repo,
  username: "blend",
  password: "blend",
  database: "farm_test",
  hostname: "localhost",
  port: 5433,
  pool: Ecto.Adapters.SQL.Sandbox
