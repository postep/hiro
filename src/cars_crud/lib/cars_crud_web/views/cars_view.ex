defmodule CarsCrudWeb.CarsView do
  use CarsCrudWeb, :view
  alias CarsCrudWeb.CarsView

  def render("index.json", %{cars: cars}) do
    %{data: render_many(cars, CarsView, "cars.json")}
  end

  def render("show.json", %{cars: cars}) do
    %{data: render_one(cars, CarsView, "cars.json")}
  end

  def render("cars.json", %{cars: cars}) do
    %{id: cars.id,
      model: cars.model,
      vin: cars.vin,
      plates: cars.plates,
      ttl: cars.ttl}
  end
end
