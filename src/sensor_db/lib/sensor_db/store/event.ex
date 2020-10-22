defmodule SensorDb.Store.Event do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "events" do
    field :sensor, :string
    field :sensor_type, :string
    field :value, :float

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:sensor, :sensor_type, :value])
    |> validate_required([:sensor, :sensor_type, :value])
  end
end
