use Mix.Config

# Configure your database
config :api_test, ApiTest.Repo,
  username: "root",
  password: "",
  database: "api_test_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :api_test, ApiTestWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
