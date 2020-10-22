defmodule SensorDb.Repo do
  use Ecto.Repo,
    otp_app: :sensor_db,
    adapter: Ecto.Adapters.Postgres
end
