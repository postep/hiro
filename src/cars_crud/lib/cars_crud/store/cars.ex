defmodule CarsCrud.Store.Cars do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cars" do
    field :model, :string
    field :plates, :string
    field :ttl, :float
    field :vin, :string

    timestamps()
  end

  @doc false
  def changeset(cars, attrs) do
    cars
    |> cast(attrs, [:model, :vin, :plates, :ttl])
    |> validate_required([:model, :vin, :plates, :ttl])
    |> unique_constraint(:vin)
  end
end
