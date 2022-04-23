defmodule PayStation.Repo do
  use Ecto.Repo,
    otp_app: :pay_station,
    adapter: Ecto.Adapters.Postgres
end
