defmodule SensorDb.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :sensor, :string
      add :sensor_type, :string
      add :value, :float

      timestamps()
    end

  end
end
