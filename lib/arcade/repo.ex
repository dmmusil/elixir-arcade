defmodule Arcade.Repo do
  use Ecto.Repo,
    otp_app: :arcade,
    adapter: Ecto.Adapters.Postgres
end
