defmodule CarsCrud.Repo.Migrations.CreateCars do
  use Ecto.Migration

  def change do
    create table(:cars, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :model, :string
      add :vin, :text
      add :plates, :text
      add :ttl, :float

      timestamps()
    end

    create unique_index(:cars, [:vin])
  end
end
