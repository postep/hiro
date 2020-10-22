defmodule CarsCrud.Repo do
  use Ecto.Repo,
    otp_app: :cars_crud,
    adapter: Ecto.Adapters.Postgres
end
