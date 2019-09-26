defmodule Farm.Repo do
  use Ecto.Repo,
    otp_app: :farm,
    adapter: Ecto.Adapters.Postgres
end
